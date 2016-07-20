#### Global Bindings for Shiny Application
## I use this a lot for elements and functions common across the app
## These items are loaded on initial page opening, thus improving performance

## Libraries
  library(shiny)
  library(shinydashboard)
  library(devtools)
  library(stringr)
  library(wordcloud)
  library(tm)
  library(twitteR)
  library(plyr)
  library(rmarkdown)

## Title and Colour Scheme
  app.name <- "Analyse Tweets" # This appears in top-left corner and title bar in browser
  skin.colour <- "red" # Colour of the border (red, green, black, yellow or blue)

## Sharing URL and description  
  app.url <- "http://significantstats.org/shiny/analysetweets/" # Application URL for sharing buttons
  app.share.desc <- "An application to analyse tweets from a particular hastag or user" # Less than 140 Characters for twitter

## Research Team - currently set up for 3 users - to add more copy ui.R lines 61-64
  # Add the pictures of each author to www/images/
  user.names <- c("Kevin Brosnan", "Dr. Peter Fennell")
  user.web <- c("http://significantstats.org", "https://www.linkedin.com/in/peter-fennell-821bb0b3")
  user.job <- c("Applied Statistician", "Mathematician")
  user.pic <- c("images/kevinbrosnan.png", "images/peterfennell.png")
  users <- as.data.frame(cbind(user.names, user.web, user.job, user.pic))
  
## GitHub - currently hidden - uncomment the code in ui.R lines 65-70
  github.repo <- "http://github.com/significantstats/analysetweets"
  github.issues <- paste0(github.repo, "/issues")

## Google Analytics - currently hidden - requires a GA Tracking ID
  # If required uncomment line 78 of ui.R and add the GA Tracking ID to line
  # 6 of www/js/google-analytics.js
  
## Load Positive and Negative Sentiment Keywords
  pos.words <- readLines("www/data/positive_words.txt")
  neg.words <- readLines("www/data/negative_words.txt")
  
## Twitter Authentication
  consumerKey <- "tyrnXx1HxXQX76VK9JiU0nPtn"
  consumerSecret <- "nJHtqeN5ULZRpU8YkMAGAzmkLWaBny9euJX85haS89nWvxOzUs"
  accessToken <- "480448035-mIU3EXiZEEAM7XYXbddlpGbi4dn4W5zdoFoFypR5"
  accessTokenSecret <- "4pooDOcSyZM1n1AyH3JWcgowXUeHJOlOLQjt7OyXSSIfu"
  setup_twitter_oauth(consumerKey,consumerSecret,accessToken,accessTokenSecret)
  
## Source Relevant Functions
  source("www/funcs/helperfunctions.R")
  source("www/funcs/twitteRfunctions.R")