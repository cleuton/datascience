# Dataframes
# Baixe os arquivos CSV do repositório: https://github.com/cleuton/datascience/tree/master/datasets
df <- read.csv('desemprego.csv')

# Estrutura:
str(df)

# Estatística:
print(summary(df))

# Primeiras 6 linhas / últimas 6 linhas:
print(head(df))
print(tail(df))

# Arquivos CSV não convencionais:
df2 <- read.csv('dataset-nao-convencional.csv',dec = ',', sep = ";")
str(df2)
print(summary(df2))

# Especificando as classes das colunas: 
# logical, integer, numeric, character, raw, "factor", "Date"
df3 <- read.csv('dataset-nao-convencional.csv',dec = ',', sep = ";", 
      colClasses= c('character','integer','numeric'))

# Datas: 
df4 <- read.csv('datas.csv',colClasses=c('Date','integer', 'numeric'))
str(df4)
print(head(df4))
print(as.numeric(format(df4$Nascimento, "%m")))

# Datas não convencionais:
df5 <- read.csv('desemprego.csv', colClasses = c('character','numeric'))
str(df5)

df6 <- read.csv('datas-horas.csv', colClasses = c('character', 'numeric', 'numeric'))
str(df6)
df6$Nascimento <- strptime(df6$Nascimento,format='%d-%m-%Y %H:%M:%S')
str(df6)
print(head(df6))

# Lidando com valores faltantes retirando as linhas

df <- na.omit(read.csv('faltando-valor.csv'))
print(head(df))

# Lidando com valores faltantes substituindo-os pela média: 

df2 <- read.csv('faltando-valor.csv')
print(summary(df2))
df2$Inflacao[is.na(df2$Inflacao)] <- mean(df2$Inflacao, na.rm = TRUE)
print(head(df2))



