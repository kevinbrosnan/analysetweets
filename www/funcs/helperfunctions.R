####------ Functions used in Server and UI Code ------####

#### Package Loading functions ####

   
#    ensure_twitteR <- function(){
#       if(!require("twitteR", character.only = TRUE)){
#          install_github(repo = "geoffjentry/twitteR")
#          require("twitteR", character.only = TRUE)
#       }
#    }
   
   ensure_leaflet <- function(){
      if(!require("leaflet", character.only = TRUE)){
         devtools::install_github(repo = "rstudio/leaflet")
         require("leaflet", character.only = TRUE)
      }
   }

#    ensure_shinyapps <- function(){
#       if(!require("shinyapps", character.only = TRUE)){
#          install_github(repo = "rstudio/shinyapps")
#          require("shinyapps", character.only = TRUE)
#       }
#    }