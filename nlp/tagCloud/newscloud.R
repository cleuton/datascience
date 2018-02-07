library(readr)
library(dplyr)
library(stringr)
library(wordcloud)
library(tidytext)

library(tidyRSS)

#I'm using a Portuguese list. If you want to analyze english feeds, just uncomment next line:
#data("stop_words")

#If you will analyze an english feed, comment next line:
stopwords <- read_csv('portuguese-stopwords.txt', col_names = 'word')

feed <- tidyfeed("https://<feed1>")
feed2 <- tidyfeed("https://<feed2>")

feedall <- bind_rows(feed,feed2)

#if you want analyze english feeds, uncomment the following block and comment the next:

#rss_t <- feedall %>%
#  unnest_tokens(word,item_title) %>%
#  anti_join(stop_words,by="word")


rss_t <- feedall %>%
  unnest_tokens(word,item_title) %>%
  anti_join(stopwords,by="word") 

words = rss_t %>% 
  group_by(word) %>% 
  summarise(freq = n()) %>% 
  arrange(desc(freq)) 

words = as.data.frame(words)

rownames(words) = words$word

library(wordcloud)

options(warn=-1)
wordcloud(words$word,words$freq,scale=c(8,.02),min.freq=3,max.words=Inf,colors=brewer.pal(8,"Dark2"))
options(warn=0)
