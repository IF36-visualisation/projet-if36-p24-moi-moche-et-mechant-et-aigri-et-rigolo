library(shiny)
library(dplyr)
library(ggplot2)
library(maps)
library(RColorBrewer)

# Fonction pour générer un vecteur de couleurs
generate_colors <- function(num_colors) {
  color_palette <- brewer.pal(num_colors, "Set3")
  color_gradient <- colorRampPalette(color_palette)
  color_gradient(num_colors)
}

# Logique du serveur pour dessiner les graphiques
function(input, output, session) {
  
  # Graphique de la sensibilité des héros
  output$heroPlot <- renderPlot({
    hero_counts <- player_data %>%
      group_by(Hero) %>%
      summarize(count = n()) %>%
      arrange(desc(count))
    
    top_heroes <- hero_counts %>%
      top_n(input$num, count) %>%
      pull(Hero)
    
    top_heroes_data <- player_data %>%
      filter(Hero %in% top_heroes)
    
    mean_sensibilite <- top_heroes_data %>%
      group_by(Hero) %>%
      summarize(mean_sensibilite_standardisee = mean(sensibilite_standardisee))
    
    top_heroes_sensibilite <- hero_counts %>%
      filter(Hero %in% top_heroes) %>%
      left_join(mean_sensibilite, by = "Hero") %>%
      arrange(desc(count))
    
    hero_colors <- generate_colors(length(top_heroes))
    
    ggplot(top_heroes_sensibilite, aes(x = reorder(Hero, -count), 
                                       y = mean_sensibilite_standardisee, fill = Hero)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label = round(mean_sensibilite_standardisee, 1)), vjust = -0.3) +
      labs(title = "Moyenne des sensibilités des héros les plus joués",
           x = "Héros", y = "Moyenne des sensibilités") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
            axis.text.y = element_text(size = 10),
            plot.title = element_text(size = 14, face = "bold")) +
      scale_fill_manual(values = hero_colors)
  })
  
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
}
