library(shiny)
library(shinydashboard)
library(readr)
library(dplyr)
library(ggplot2)

# Charger le dataset principal
data <- read_csv("../data/ow2_quickplay_heroes_stats__2023-05-06.csv")

# Charger les datasets des saisons
datas1 <- read_csv("../data/ow2_season_01_FINAL_heroes_stats__2023-05-06.csv")
datas2 <- read_csv("../data/ow2_season_02_FINAL_heroes_stats__2023-05-06.csv")
datas3 <- read_csv("../data/ow2_season_03_FINAL_heroes_stats__2023-05-06.csv")
datas4 <- read_csv("../data/ow2_season_04_FINAL_heroes_stats__2023-06-27.csv")

# Interface utilisateur pour le dashboard
ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Moi, moche et méchant et aigri et rigolo", titleWidth = 450),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Héros les plus joués", tabName = "top_heroes", icon = icon("star")),
      menuItem("Gains des Joueurs", tabName = "earnings", icon = icon("usd")),
      menuItem("Dégâts en fonction des saisons", tabName = "seasonal_damage", icon = icon("fire"))
    )
  ),
  dashboardBody(
    tabItems(
      # Onglet pour les héros les plus joués
      tabItem(tabName = "top_heroes",
              fluidRow(
                box(
                  sliderInput("num", "Nombre de héros à afficher:", min = 1, max = 36, value = 10, step = 1),
                  plotOutput("topHeroesPlot"), width = 12
                )
              )),
      # Onglet pour les gains des joueurs
      tabItem(tabName = "earnings",
              fluidRow(
                selectInput("gameType", "Choisir le type de jeu:",
                            choices = c("Tous les jeux" = "all", "Overwatch" = "overwatch")),
                plotOutput("gameMap")
              )),
      # Onglet pour les dégâts en fonction des saisons
      tabItem(tabName = "seasonal_damage",
              fluidRow(
                checkboxGroupInput("seasons", "Sélectionner les saisons à afficher:",
                                   choices = list("Saison 1" = "s1", "Saison 2" = "s2", "Saison 3" = "s3", "Saison 4" = "s4"),
                                   selected = c("s1", "s2", "s3", "s4")),
                plotOutput("seasonalDamagePlot")
              ))
    )
  )
)
