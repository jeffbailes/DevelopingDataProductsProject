library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Are You Screwed?"),
  sidebarPanel(
    radioButtons("transmission", "Transmission:",
                 c("Manual" = "manual",
                   "Automatic" = "automatic")
    ),
    numericInput("mass", "Mass of car (kg):", 1000, min=0, max=100000, step=200),
    numericInput("kw", "Car's Kilowatts:", 110, min=0, max=10000, step=5),
    numericInput("qm", "Time to drive 402 metres (seconds):", 18, min=0, max=3600, step=2),
    numericInput("dist", "Distance to the next petrol station (km):", 50, min=0, max=100000, step=25),
    numericInput("petrol", "Litres of petrol you have in the tank:", 5, min=0, max=500, step=1)
    ),
  mainPanel(
    tabsetPanel(tabPanel("Results",
                            h4("Distance to closest petrol station (km):"),
                            verbatimTextOutput("petrolStationDistance"),
                            h4("How far you can drive on the current tank (km):"),
                            verbatimTextOutput("calculatedDistance"),
                            h4("Outcome / hints"),
                            verbatimTextOutput("outText")),
                tabPanel("Help", includeMarkdown('help.Rmd')))
  )
))