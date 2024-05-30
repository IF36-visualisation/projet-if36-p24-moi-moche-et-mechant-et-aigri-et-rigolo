library(shiny)
library(shinydashboard)
library(readr)
library(dplyr)
library(ggplot2)

# Chargement des données des joueurs
player_data <- read_csv("../data/player_settings.csv")
dpi_reference <- 800

# Préparation des données
player_data <- player_data %>%
  mutate(
    Sensitivity = as.numeric(Sensitivity),
    DPI = as.numeric(DPI),
    ratio_sensibilite = Sensitivity / DPI,
    sensibilite_standardisee = ratio_sensibilite * dpi_reference
  )

# Calcul du nombre total de héros
num_heroes <- player_data %>%
  count(Hero) %>%
  nrow()

# Interface utilisateur pour le dashboard
ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Moi, moche et méchant et aigri et rigolo", titleWidth = 450),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Sensibilité des Joueurs", tabName = "sensitivity", icon = icon("gamepad")),
      menuItem("Gains des Joueurs", tabName = "earnings", icon = icon("usd")),
      sliderInput("num", "Nombre de héros à afficher:", min = 1, max = num_heroes, value = 10, step = 1)
    )
  ),
  dashboardBody(
    tabItems(
      # Onglet pour la sensibilité des joueurs
      tabItem(tabName = "sensitivity",
              fluidRow(
                box(plotOutput("heroPlot"), width = 12)
              )),
      # Onglet pour les gains des joueurs
      tabItem(tabName = "earnings",
              fluidRow(
                selectInput("gameType", "Choisir le type de jeu:",
                            choices = c("Tous les jeux" = "all", "Overwatch" = "overwatch")),
                plotOutput("gameMap")
              ))
    )
  )
)
