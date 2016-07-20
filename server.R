####------ Server Side Code for twitteR Application ------####

shinyServer(function(input, output, session) {
  
  tweets <- reactive({
    
    tweets <- searchTwitter(input$hashtag, n = 100, retryOnRateLimit = 1)
    
    tweets_df <- twListToDF(tweets)
    
  })
  
  output$timeseries <- renderPlot({
    created <- tweets()$created
    # bin creation times hourly
    created_hourly <- format(created,'%d/%b, %H.00')
    counts <- table(created_hourly)
    plot(na.omit(counts), type = "h", xaxt = "n", 
         ylab = "Tweet Counts", xlab = "", las = 1)
    title(paste("Frequency of tweets for ", input$hashtag, sep = ""))
    #label x-axis
    counts_names = names(counts)
    axis(1, at = 1:length(counts), labels = counts_names, tick = FALSE)
  })
  
  timeseriespdf <- reactive({
    created <- tweets()$created
    # bin creation times hourly
    created_hourly <- format(created,'%d/%b, %H.00')
    counts <- table(created_hourly)
    plot(na.omit(counts), type = "h",xaxt = "n", 
         ylab = "Tweet Counts", xlab = "", las = 1)
    #label x-axis
    counts_names = names(counts)
    axis(1, at = 1:length(counts), labels = counts_names, tick = FALSE)
  })
  
  output$sentimentanalysis <- renderPlot({
    tw <- tweets()$text
    
    scores <- score_sentiment(tw, pos.words, neg.words)
    
    totaltweets <- nrow(scores)
    perPositive <- length(which(scores$score > 0))/totaltweets
    perNegative <- length(which(scores$score < 0))/totaltweets
    perNeutral <- 1 - perPositive - perNegative
    
    barplot(height = c(perNegative, perNeutral, perPositive), 
            col = c("red", "grey", "green"), 
            names.arg = c("Negative", "Neutral", "Positive"))
    legend(x = "topright", legend = c("Negative", "Neutral", "Positive"), 
           fill = c("red", "grey", "green"))
    title(paste("Sentiment Analysis Chart for ", input$hashtag, sep = ""))
  })
  
  sentimentanalysispdf <- reactive({
    tw <- tweets()$text
    
    scores <- score_sentiment(tw, pos.words, neg.words)
    
    totaltweets <- nrow(scores)
    perPositive <- length(which(scores$score > 0))/totaltweets
    perNegative <- length(which(scores$score < 0))/totaltweets
    perNeutral <- 1 - perPositive - perNegative
    
    barplot(height = c(perNegative, perNeutral, perPositive), 
            col = c("red", "grey", "green"), 
            names.arg = c("Negative", "Neutral", "Positive"))
    legend(x = "topright", legend = c("Negative", "Neutral", "Positive"), 
           fill = c("red", "grey", "green"))
  })
  
  output$wordcloud <- renderPlot({
    tw <- tweets()$text
    
    text_corpus <- wordcloud_corpus(tw)
    wordcloud(text_corpus, max.words = 300, random.order = FALSE, 
              colors=brewer.pal(8, "Set2"), rot.per = 0.0, fixed.asp = FALSE, 
              scale = c(3,0.5), random.color = FALSE)
    title(paste("Wordcloud for ", input$hashtag, sep = ""))
  })
  
  wordcloudpdf <- reactive({
    tw <- tweets()$text
    
    text_corpus <- wordcloud_corpus(tw)
    wordcloud(text_corpus, max.words = 300, random.order = FALSE, 
              colors=brewer.pal(8, "Set2"), rot.per = 0.0, fixed.asp = FALSE, 
              scale = c(3,0.5), random.color = FALSE)
  })
  
  output$downloadData <- downloadHandler(
    filename <- function(){ 
      paste(input$hashtag, '.csv', sep='') 
    },
    content <- function(file){
      write.csv(tweets()$text, file, row.names = FALSE, col.names = FALSE)
    }
  )
  
  output$report = downloadHandler(
    filename <- function(){
      paste(input$hashtag, ".pdf", sep = "")
    },
    content = function(file){
      src <- normalizePath('www/docs/report.Rmd')
      
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'report.Rmd')
      
      out <- render('report.Rmd', pdf_document())
      file.rename(out, file)
    }
  )
  
})