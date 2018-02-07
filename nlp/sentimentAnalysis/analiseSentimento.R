#Neste trabalho, usamos o dicionário léxico OpLexicon:
#  Souza, M.; Vieira, R. Sentiment Analysis on Twitter Data for Portuguese Language. 10th International Conference Computational Processing of the Portuguese Language, 2012. [pdf] [bib]

#  Souza, M.; Vieira, R.; Busetti, D.; Chishman, R. e Alves, I. M. Construction of a Portuguese Opinion Lexicon from multiple resources. 8th Brazilian Symposium in Information and Human Language Technology, 2011. [pdf] [bib]
#http://ontolp.inf.pucrs.br/Recursos/downloads-OpLexicon.php
library(readr)
library(dplyr)
library(stringr)
library(wordcloud)
library(tidytext)
library(tidyRSS)
oplexicon <- read_csv('oplexicon_v3.0/lexico_v3.0.txt', col_names = c('word', 'type', 'weight', 'other'), col_types = 
                        cols(
                          word = col_character(),
                          type = col_character(),
                          weight = col_integer(), 
                          other = col_character()
                        ))
head(oplexicon)
stopwords <- read_csv('portuguese-stopwords.txt', col_names = 'word')

feed <- tidyfeed("https://oglobo.globo.com/rss.xml?completo=true")
rss_t <- feed %>%
  unnest_tokens(word,item_title) %>%
  anti_join(stopwords,by="word") 

sentimentoFeed <- rss_t %>%
  inner_join(oplexicon) %>%
  group_by(item_link) %>%
  summarize(peso = sum(weight, na.rm = TRUE))
print(sentimentoFeed)