library(shiny)

fluidPage(
  titlePanel("Statistiques des Héros d'Overwatch"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("graph_type", "Choisir le graphique :", 
                  choices = c("HPS" = "hps", "DPS" = "dps", "Vie" = "life"))
    ),
    
    mainPanel(
      uiOutput("selected_graph")
    )
  )
)
