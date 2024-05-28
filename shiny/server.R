library(shiny)
library(dplyr)
library(ggplot2)

# Fonction pour générer un vecteur de couleurs
generate_colors <- function(num_colors) {
  color_palette <- brewer.pal(num_colors, "Set3")
  color_gradient <- colorRampPalette(color_palette)
  color_gradient(num_colors)
}

# Define server logic required to draw the plot
function(input, output, session) {
  
  output$heroPlot <- renderPlot({
    # Calcul du nombre de fois que chaque héros est joué et tri par ordre décroissant
    hero_counts <- player_data %>%
      group_by(Hero) %>%
      summarize(count = n()) %>%
      arrange(desc(count))
    
    # Sélection des héros en fonction de l'entrée utilisateur
    top_heroes <- hero_counts %>%
      top_n(input$num, count) %>%
      pull(Hero)
    
    # Filtrer les données pour inclure seulement les héros sélectionnés
    top_heroes_data <- player_data %>%
      filter(Hero %in% top_heroes)
    
    # Calcul des moyennes de sensibilité standardisée pour les héros sélectionnés
    mean_sensibilite <- top_heroes_data %>%
      group_by(Hero) %>%
      summarize(mean_sensibilite_standardisee = mean(sensibilite_standardisee))
    
    # Joindre les données pour obtenir le classement des héros les plus joués avec leur moyenne de sensibilité
    top_heroes_sensibilite <- hero_counts %>%
      filter(Hero %in% top_heroes) %>%
      left_join(mean_sensibilite, by = "Hero") %>%
      arrange(desc(count))
    
    # Calcul des couleurs pour les héros sélectionnés
    hero_colors <- generate_colors(length(top_heroes))
    
    # Afficher les résultats dans un graphique à barres
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
}
