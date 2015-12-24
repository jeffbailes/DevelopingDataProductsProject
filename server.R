library(shiny)
data(mtcars)
transmission <- factor(mtcars$am, levels=c(0,1), labels=c("automatic", "manual"))
fit <- lm(mpg ~ transmission + wt + hp + qsec, data=mtcars)

# Conversion of units functions.
kgToThouPound <- function(kg) {
  (kg / 1000) * 2.20462
}

litreToGallon <- function(litre) {
  0.264172 * litre
}

kwToHP <- function(kw) {
  1.34102 * kw
}

milesTokm <- function(miles) {
  1.60934 * miles
}

shinyServer(
  function(input, output) {
    prediction <- reactive({milesTokm(litreToGallon(input$petrol) * predict(fit, data.frame(transmission=input$transmission, wt=kgToThouPound(input$mass), hp=kwToHP(input$kw), qsec=input$qm)))})
    output$petrolStationDistance <- renderPrint({input$dist})
    output$calculatedDistance <- renderPrint({prediction()})
    output$outText <- renderText({
      if (prediction() > input$dist) {
        "No problem!  You're not skrewed at all!  You can defo make it to the next petrol station."
      } else if (-prediction() > input$dist) {
        "You're not too skrewed.  You can make it to the next petrol station, but only if you drive in reverse the whole way."
      } else if (input$transmission == "automatic") {
        "You're mostly skrewed, though have you considered converting your car to manual before you set off?"
      } else {
        tmp <- sample(c("Take a hammer to your engine - if you reduce your car's kilowatt output, your fuel efficiency will increase!",
                        "Accelerate slower - increasing your car's 402 metre time makes it more fuel efficient!",
                        "Fill your car with rocks - if your car becomes heavy enough, you can just reverse your way there!",
                        "Wait a couple of decades - your car will surely be more efficient in the future."),
                      1)
        paste("You're pretty skrewed, however, here is a helpful hint to maximise your chance of success:", tmp, sep='\n')
    }
    })
  }
)