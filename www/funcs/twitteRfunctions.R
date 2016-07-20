####------ Functions used on twitteR data in twitteR Application ------####

#### Clean tweets to remove unused information ####

clean_tweets <- function(tweets){
   
   # extracts the text of each tweet via the function getText
   text <- tweets
   
   # Remove all occorances of hashtags
   text <- gsub("#\\w+", "", text, ignore.case = TRUE)
   
   # Remove @UserName and & symbol
   text <- gsub("@\\w+", "", text)
   text <- gsub("&amp", "", text)
   
   # Remove punctuation
   text <- gsub("[[:punct:]]", "", text)
   
   # Remove hypertext links
   text <- gsub("http\\w+", "", text)
   
   # next line ensures that text is ASCII and removes smiley faces etc
   text <- sapply(text,function(x) iconv(x, "latin1", "ASCII", sub=""))
   
   # bring text to lower case
   text <- sapply(text,function(row) tolower(row)) 
   
   return(text)
} 

#### Worcloud for frequency of words in tweets ####

wordcloud_corpus <- function(tweets){

   text <- clean_tweets(tweets = tweets)
   
   corpus <- VCorpus(VectorSource(text))
   corpus <- tm_map(corpus, function(x) removeWords(x,stopwords()))
   corpus <- tm_map(corpus, PlainTextDocument)
   
   return(corpus)
}

#### Score Sentiment within tweets ####

score_sentiment <- function(tweets, pos.words = pos.words, neg.words = neg.words){
   
   text <- clean_tweets(tweets)
   
   scores <- laply(text, function(row, pos.words, neg.words){
      
      # Split sentences into words and then unlist them
      word.list <- str_split(row, "\\s+")
      words <- unlist(word.list)
      
      # Compare words to positive and negative words
      pos.matches <- match(words, pos.words)
      neg.matches <- match(words, neg.words)
      
      # Remove NA's from vectors
      pos.matches <- !is.na(pos.matches)
      neg.matches <- !is.na(neg.matches)

      # Calculate the score of the tweet
      score <- sum(pos.matches) - sum(neg.matches)
      
      return(score)
      
   }, pos.words, neg.words)
 
   scores.df <- data.frame(score = scores, text = text)
   return(scores.df)  
}

#### Ordered time origin of when tweets were created ####

tweet_times_order <- function(tweets){
   
   tweet_times = sapply(tweets, function(x) x$created)
   order(tweet_times)
   
}


#### Ordered retweet popularity function ####

RTcount_order <- function(tweets){
   
   # Consider only tweets which are original tweets, i.e., not retweets
   RT = sapply(tweets, function(x) x$isRetweet)
   RT_indices = which(RT)
   seed_tweets = tweets[setdiff(1:length(tweets), RT_indices)]
   
   
   # list of number of times the list has been retweeted
   RTcount = sapply(seed_tweets, function(x) x$retweetCount)
   
   #index of the most retweeted tweets, i.e., RTcount_order[1] is the index of the most retweeted tweet
   order(RTcount, decreasing = TRUE)
   
}

#### Ordered favourite popularity function ####

FVcount_order <- function(tweets){
   
   # POPULARITY BASED ON FAVOURITED
   # list of whether tweet is a retweet or not
   FVcount = sapply(tweets, function(x) x$favoriteCount)
   
   #index of the most favourited tweets, i.e., FVcount_order[1] is the index of the most favourited tweet
   order(FVcount, decreasing = TRUE)
   
}