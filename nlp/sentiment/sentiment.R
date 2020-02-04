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
#Neste trabalho, usamos o dicionário léxico OpLexicon:
#  Souza, M.; Vieira, R. Sentiment Analysis on Twitter Data for Portuguese Language. 10th International Conference Computational Processing of the Portuguese Language, 2012. [pdf] [bib]

#  Souza, M.; Vieira, R.; Busetti, D.; Chishman, R. e Alves, I. M. Construction of a Portuguese Opinion Lexicon from multiple resources. 8th Brazilian Symposium in Information and Human Language Technology, 2011. [pdf] [bib]
#http://ontolp.inf.pucrs.br/Recursos/downloads-OpLexicon.php
library(readr)
library(dplyr)
library(stringr)
library(tidytext)
shome = Sys.getenv("SENTIMENT_HOME")
setwd(shome)
oplexicon <- read_csv('./oplexicon_v3.0/lexico_v3.0.txt', col_names = c('word', 'type', 'weight', 'other'), col_types = 
                        cols(
                          word = col_character(),
                          type = col_character(),
                          weight = col_integer(), 
                          other = col_character()
                        ))
head(oplexicon)
stopwords <- read_csv('portuguese-stopwords.txt', col_names = 'word')
fhome = Sys.getenv("SENTIMENT_TEXT")
file_list <- list.files(path=fhome)
setwd(fhome)
graphdata <- c(0,0,0,0,0)
graphlabel <- c("Muito insatisfeito","Insatisfeito", "Neutro", "Satisfeito", "Muito satisfeito")
locale(date_names = "en", date_format = "%AD", time_format = "%AT",
  decimal_mark = ".", grouping_mark = ",", tz = "UTC",
  encoding = "UTF-8", asciify = FALSE)
default_locale()
for (i in 1:length(file_list)){
  filename <- file_list[i]
  feed <- read_file(filename,locale= locale(encoding="UTF-8"))
  tdf <- tibble(line=1:1,text=feed)
  rss_t <- tdf %>%
    unnest_tokens(word,text) %>%
    anti_join(stopwords,by="word") 
  
  sentimentoFeed <- rss_t %>%
    inner_join(oplexicon) %>%
    group_by(line) %>%
    summarize(peso = sum(weight, na.rm = TRUE))
  print(feed)
  evaluation <- sentimentoFeed[["peso"]]
  evaluation <- ifelse(length(evaluation)==0,0,evaluation)
  slicevalue <- 1
  print(evaluation)
  if (evaluation == 0) {
    slicevalue <- 3
  } else if (evaluation < -1) {
      slicevalue <- 1
  } else if (evaluation < 0) {
      slicevalue <- 2
  } else if (evaluation > 1) {
      slicevalue <- 5
  } else {slicevalue <- 4}
  graphdata[slicevalue] <- graphdata[slicevalue] + 1
}
fname <- paste(shome,"/result.jpg",sep="")
jpeg(filename=fname,width=800,height=800)
pie(graphdata, labels = graphlabel, main="Satisfação dos clientes")
dev.off()

