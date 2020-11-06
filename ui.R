suppressWarnings(library(shiny))
suppressWarnings(library(markdown))

shinyUI(navbarPage("The Crystal Ball",
                   tabPanel("Let it read your mind!",
                            sidebarLayout(sidebarPanel(textInput("inputString", "Type a short sentence:", value = "")),
                            mainPanel(strong("Prediction:"), br(), br(), textOutput('text1')))),
                            mainPanel(includeMarkdown("about.md"))))