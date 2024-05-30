library(shiny)
library(dplyr)
library(ggplot2)
library(readr)

# Charger les datasets
datas1 <- read_csv("../data/ow2_season_01_FINAL_heroes_stats__2023-05-06.csv")
datas2 <- read_csv("../data/ow2_season_02_FINAL_heroes_stats__2023-05-06.csv")
datas3 <- read_csv("../data/ow2_season_03_FINAL_heroes_stats__2023-05-06.csv")
datas4 <- read_csv("../data/ow2_season_04_FINAL_heroes_stats__2023-06-27.csv")

# Fonction pour générer un vecteur de couleurs
generate_colors <- function(num_colors) {
  color_palette <- brewer.pal(num_colors, "Set3")
  color_gradient <- colorRampPalette(color_palette)
  color_gradient(num_colors)
}

shinyServer(function(input, output) {
  
  # Logique pour le rendu de la carte des gains des joueurs
  output$gameMap <- renderPlot({
    # Sélection des données selon le type de jeu choisi
    sub_players <- if (input$gameType == "overwatch") {
      players[players$Game == "Overwatch", ]
    } else {
      players
    }
    sub_players$CountryCode <- tolower(sub_players$CountryCode)
    
    country_codes$Country_Name <- sub(",.*", "", country_codes$Country_Name)
    country_codes$Two_Letter_Country_Code <- tolower(country_codes$Two_Letter_Country_Code)
    
    merged_data <- merge(sub_players, country_codes, by.x = "CountryCode", by.y = "Two_Letter_Country_Code", all.x = TRUE)
    average_earnings <- aggregate(TotalUSDPrize ~ Country_Name, data = merged_data, FUN = mean, na.rm = TRUE)
    average_earnings <- average_earnings[order(-average_earnings$TotalUSDPrize),]
    average_earnings$Country_Name <- tolower(average_earnings$Country_Name)
    
    world_map <- map_data("world")
    world_map$region <- tolower(world_map$region)
    map_data <- merge(world_map, average_earnings, by.x = "region", by.y = "Country_Name", all.x = TRUE)
    
    # Générer la carte
    ggplot(map_data, aes(x = long, y = lat, group = group, fill = TotalUSDPrize)) +
      geom_polygon() +
      scale_fill_gradient(
        low = "green", 
        high = "red", 
        na.value = "lightgrey", 
        name = "Gains Moyens (USD)", 
        limits = c(0, max(map_data$TotalUSDPrize, na.rm = TRUE))
      ) +
      coord_fixed(1.3) +
      labs(title = if (input$gameType == "overwatch") 
        "Moyenne des Gains par Nationalité des Joueurs d'Overwatch" 
        else "Moyenne des Gains par Nationalité des Joueurs de Jeux Vidéo") +
      theme_minimal()
  })
  
  # Logique pour le rendu du graphique des héros les plus joués
  output$topHeroesPlot <- renderPlot({
    # Prendre tous les niveaux de joueurs
    All_skilltier <- subset(data, `Skill Tier` == "All")
    
    # Héros les plus joués tous niveaux confondus
    ggplot(top_n(All_skilltier, input$num, `Pick Rate, %`), 
           aes(x = reorder(Hero, -`Pick Rate, %`), y = `Pick Rate, %`, fill = Role)) +
      geom_col() +
      theme_minimal() +
      labs(title = "Héros les plus joués tous niveaux confondus", x = "Héros", y = "Pick Rate (%)") +
      theme(axis.text.x = element_text(angle = 35, hjust = 1))
  })
  
  # Logique pour le rendu du graphique des dégâts par saison
  output$seasonalDamagePlot <- renderPlot({
    # Filtrer les saisons sélectionnées
    selected_datasets <- list()
    for (season in input$seasons) {
      selected_datasets[[season]] <- get(paste0("datas", gsub("s", "", season)))
    }
    
    # Calculer la moyenne des Damage / 10min pour chaque rôle dans chaque dataset sélectionné
    mean_damages <- lapply(selected_datasets, function(data) {
      data %>% group_by(Role) %>% summarise(mean_damage = mean(`Damage / 10min`))
    })
    
    # Ajouter une colonne pour identifier les jeux de données
    names(mean_damages) <- input$seasons
    mean_damages <- lapply(names(mean_damages), function(name) {
      mean_damages[[name]] %>% mutate(Dataset = name)
    })
    
    # Combiner les moyennes dans un seul dataframe
    combined_means <- bind_rows(mean_damages)
    
    # Choisir les couleurs
    color_gradient <- c("#ffbd6e", "#ff83a6", "#98eeff", "#83ffb0")
    
    # Créer le diagramme en colonnes avec les moyennes affichées
    ggplot(combined_means, aes(x = Role, y = mean_damage, fill = Dataset)) +
      geom_col(position = position_dodge(width = 0.97), alpha = 1) +
      geom_text(aes(label = round(mean_damage)), position = position_dodge(width = 0.9), vjust = -0.5) +
      labs(title = "Moyenne de dégâts sur 10min, par rôle et par saison",
           x = "Rôle",
           y = "Moyenne des dégâts sur 10 minutes") +
      scale_fill_manual(values = color_gradient) +
      theme_minimal()
  })
  
})
