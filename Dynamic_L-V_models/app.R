#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(deSolve)

#### do the things  ####
# first just start "basic" L-V models
# from https://assemblingnetwork.wordpress.com/2013/01/31/two-species-predator-prey-systems-with-r/
parameters2 <- c(r = 2.0, alpha = 0.1, e = 0.1, q = 0.5, K = 600)
state <- c(N = 50, P = 20)

lvmodel  <- function(t, state, parameters){
    with(as.list(c(state, parameters)),{
        #rate of change
        dN <- (r*(1-N/K))-(alpha*N*P)
        dP <- (e*alpha*N*P)-(q*P)
        
        list(c(dN,dP))
    })
}

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Dynamic Lotka-Volterra models"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("times",
                        label = "Number of time steps:",
                        min = 1,
                        max = 10e5,
                        value = 100, step = 1),
            sliderInput("r",
                        label = "r = ",
                        min = 0.1,
                        max = 10,
                        value = 1.0, step = 0.1),
            sliderInput("alpha",
                        label = expression(alpha),
                        min = 0.01,
                        max = 5,
                        value = 0.01, step = 0.03),
            sliderInput("e",
                        label = "e = ",
                        min = 0.05,
                        max = 1,
                        value = 0.1, step = 0.1),
            sliderInput("N",
                        label = "N =",
                        min = 1,
                        max = 1000,
                        value = 50, step = 10),
            sliderInput("P",
                        label = "P = ",
                        min = 1,
                        max = 500,
                        value = 20, step = 10)
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("LV")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$LV <- renderPlot({
        # generate bins based on input$bins from ui.R
        parmameters <- C(r = input$r, alpha = input$alpha, e = input$e, q = 0.5,)
        out <- ode(c(N = input$N, K = input$K), times = input$times, func = lvmodel, parms = parameters)
        matplot.0D(out)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
