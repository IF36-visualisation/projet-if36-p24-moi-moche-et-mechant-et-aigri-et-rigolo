library(shiny)
library(shinydashboard)
library(readr)
library(dplyr)
library(ggplot2)

player_data <- read_csv("../data/player_settings.csv")
dpi_reference <- 800

str(player_data)
player_data$Sensitivity <- as.numeric(player_data$Sensitivity)
player_data$DPI <- as.numeric(player_data$DPI)

player_data <- player_data %>% 
  mutate(ratio_sensibilite = Sensitivity / DPI,
         sensibilite_standardisee = ratio_sensibilite * dpi_reference)

# Nombre total de héros
num_heroes <- player_data %>% count(Hero) %>% nrow()

#DASHBOARD
dashboardPage(skin = "purple",
              dashboardHeader(title = "Moi, moche et méchant et aigri et rigolo", titleWidth = 450),
              dashboardSidebar(
                sidebarMenu(
                  sliderInput("num", "Nombre de héros à afficher:", min = 1, max = num_heroes, value = 10, step = 1)
                )
              ),
              dashboardBody(
                tabItem(tabName = "dashboard",
                        fluidRow(
                          box(plotOutput("heroPlot"), width = 12)
                        )
                )
              )
)
