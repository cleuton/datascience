#Copyright 2018 Cleuton Sampaio
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#
# In this code I used the AFINN lexicon file: 
# http://www2.imm.dtu.dk/pubdb/views/publication_details.php?id=6010
#
library(readr)
library(dplyr)
library(stringr)
library(tidytext)
library(stopwords)
shome = Sys.getenv("SENTIMENT_HOME")
setwd(shome)
oplexicon <- read_csv('./AFINN-111.csv', col_names = c('word', 'weight'), col_types = 
                        cols(
                          word = col_character(),
                          weight = col_integer()
                        ))
head(oplexicon)
word <- stopwords("en")
stpwords <- data.frame(word)
fhome = Sys.getenv("SENTIMENT_TEXT_ENGLISH")
file_list <- list.files(path=fhome)
setwd(fhome)
graphdata <- c(0,0,0,0,0)
graphlabel <- c("Very dissatisfied","Dissatisfied", "Neutral", "Satisfied", "Very Satisfied")
locale(date_names = "en", date_format = "%AD", time_format = "%AT",
  decimal_mark = ".", grouping_mark = ",", tz = "UTC",
  encoding = "UTF-8", asciify = FALSE)
default_locale()
for (i in 1:length(file_list)){
  filename <- file_list[i]
  feed <- read_file(filename)
  tdf <- tibble(line=1:1,text=feed)
  rss_t <- tdf %>%
    unnest_tokens(word,text) %>%
    anti_join(stpwords,by="word") 
  
  sentimentoFeed <- rss_t %>%
    inner_join(oplexicon) %>%
    group_by(line) %>%
    summarize(peso = sum(weight, na.rm = TRUE))
  print(feed)
  evaluation <- sentimentoFeed[["peso"]]
  evaluation <- ifelse(length(evaluation)==0,0,evaluation)
  slicevalue <- 1
  
  if (evaluation == 0) {
    slicevalue <- 3
  } else if (evaluation < -2) {
      slicevalue <- 1
  } else if (evaluation < 0) {
      slicevalue <- 2
  } else if (evaluation < 2) {
      slicevalue <- 4
  } else {slicevalue <- 5}
  graphdata[slicevalue] <- graphdata[slicevalue] + 1
  print(slicevalue)
}
fname <- paste(shome,"/result_english.jpg",sep="")
jpeg(filename=fname,width=800,height=800)
pie(graphdata, labels = graphlabel, main="Customer's satisfaction")
dev.off()

