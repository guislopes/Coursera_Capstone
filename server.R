suppressWarnings(library(tm))
suppressWarnings(library(stringr))
suppressWarnings(library(shiny))

quadgram <- readRDS("quadgram.RData"); trigram <- readRDS("trigram.RData"); bigram <- readRDS("bigram.RData");

nextword <- function(x) {xclean <- removeNumbers(removePunctuation(tolower(x))); cw <- strsplit(xclean, " ")[[1]]
if (length(cw) >= 3) {cw <- tail(cw,3)
if (identical(character(0), head(quadgram[quadgram$unigram == cw[1] & quadgram$bigram == cw[2] & quadgram$trigram == cw[3], 4], 1))){
  nextword(paste(cw[2],cw[3],sep=" "))
} else {head(quadgram[quadgram$unigram == cw[1] & quadgram$bigram == cw[2] & quadgram$trigram == cw[3], 4], 1)}
} else if (length(cw) == 2){cw <- tail(cw,2)
if (identical(character(0),head(trigram[trigram$unigram == cw[1] & trigram$bigram == cw[2], 3], 1))) {
  nextword(cw[2])
} else {head(trigram[trigram$unigram == cw[1] & trigram$bigram == cw[2], 3], 1)}
} else if (length(cw) == 1){cw <- tail(cw,1)
if (identical(character(0),head(bigram[bigram$unigram == cw[1], 2], 1))) {head("...what? [NO MATCHES]",1)}
else {head(bigram[bigram$unigram == cw[1],2],1)}
}}

shinyServer(function(input, output) {
  output$text1 <- renderText({
    o <- try(paste(input$inputString, if(as.character(nextword(input$inputString)) == "i"){"I"}else{as.character(nextword(input$inputString))}), silent = T)
    if(substr(o[1],1,5) == "Error"){paste("")}else{
      paste(input$inputString, if(as.character(nextword(input$inputString)) == "i"){"I"}else{as.character(nextword(input$inputString))})}
  })})