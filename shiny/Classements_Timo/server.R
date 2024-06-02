library(shiny)
library(tidyverse)

# Chargement des données
heroes <- read.csv("../../data/Overwatch_edopic.csv")

# Préparation des données pour chaque graphique
heroes <- rename(heroes, Damage_per_sec = `Damage per second`)
heroes <- mutate(heroes, DPS = Damage_per_sec)

heroes3 <- rename(heroes, Heal_per_sec = `Health per Sec`)
heroes3 <- mutate(heroes3, HPS = Heal_per_sec)
heroes3 <- filter(heroes3, !grepl(" ", Heroes) & HPS > 1 & Heroes != "Reaper" & Heroes != "Soldier")
heroes3 <- arrange(heroes3, desc(HPS))
top_10_heroes_hps <- head(heroes3, 10)

heroes2 <- filter(heroes, !grepl(" ", Heroes) | Heroes == "D.va Mech" | Heroes == "Roadhog" | Heroes =="Bastion Recon" | Heroes =="Bastion Turret", !is.na(Life))
heroes2 <- mutate(heroes2, Life = as.integer(Life))
heroes2 <- arrange(heroes2, desc(Life))
top_10_heroes_life <- head(heroes2, 10)

heroes1 <- rename(heroes, Damage_per_sec = `Damage per second`)
heroes1 <- mutate(heroes1, DPS = Damage_per_sec)
heroes1 <- mutate(heroes1, Heroes = case_when(
  Heroes == "Bastion Recon" ~ "Bastion_Recon",
  Heroes == "Bastion Turret" ~ "Bastion_Turret",
  TRUE ~ Heroes
))
heroes1 <- filter(heroes1, !grepl(" ", Heroes))
heroes1 <- arrange(heroes1, desc(DPS))
top_10_heroes <- head(heroes1, 10)

function(input, output) {
  output$selected_graph <- renderUI({
    if (input$graph_type == "hps") {
      ggplotOutput("hps_plot")
    } else if (input$graph_type == "dps") {
      ggplotOutput("dps_plot")
    } else if (input$graph_type == "life") {
      ggplotOutput("life_plot")
    }
  })
  
  output$hps_plot <- renderPlot({
    ggplot(top_10_heroes_hps, aes(x = reorder(Heroes, -HPS), y = HPS, label = HPS)) +
      geom_bar(stat = "identity", fill = "green") +
      geom_text(position = position_dodge(width = 0.9), vjust = -0.5, size = 3) +
      labs(title = "Top 10 héros avec le plus de soins par seconde",
           x = "Héros",
           y = "Soins par seconde") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.border = element_blank(),
            panel.background = element_blank(),
            plot.background = element_blank())
  })
  
  output$dps_plot <- renderPlot({
    ggplot(top_10_heroes, aes(x = reorder(Heroes, -DPS), y = DPS, label = DPS)) +
      geom_bar(stat = "identity", fill = "orange") +
      geom_text(position = position_dodge(width = 0.9), vjust = -0.5, size = 3) +
      labs(title = "Top 10 héros avec le plus de dégâts par seconde",
           x = "Héros",
           y = "DPS") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.border = element_blank(),
            panel.background = element_blank(),
            plot.background = element_blank())
  })
  
  output$life_plot <- renderPlot({
    ggplot(top_10_heroes_life, aes(x = reorder(Heroes, -Life), y = Life, label = Life)) +
      geom_bar(stat = "identity", fill = "blue") +
      geom_text(position = position_dodge(width = 0.9), vjust = -0.5, size = 3) +
      labs(title = "Top 10 héros avec le plus de points de vie",
           x = "Héros",
           y = "Vie") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            panel.grid.major = element_blank(),
            panel.grid.minor = element
