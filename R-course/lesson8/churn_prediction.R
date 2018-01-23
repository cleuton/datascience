# Churn Prediction
df <- read.csv('evasao.csv')
print(head(df))
print(str(df))
print(summary(df))

# Uma maneira de verificar se faltam valores: 
print(table(is.na(df)))

# Vamos separar os dados de treino e teste:
n <- nrow(df)
limite <- sample(1:n, size = round(0.75*n), replace = FALSE)
train_df <- df[limite,]
test_df <- df[-limite,]

# Criando o modelo com os dados de teste:
modelo <- glm('abandonou ~ periodo + bolsa + repetiu + ematraso + disciplinas + faltas + desempenho', data = train_df, family = 'binomial')
print(summary(modelo))

# Avaliando com ANOVA: 
print(anova(modelo, test = "Chisq"))

# Retirando as variáveis que pouco contribuem: periodo, bolsa, ematraso, disciplinas, faltas:
train_r <- subset(train_df,select = c('repetiu','desempenho','abandonou'))

modelo2 <- glm('abandonou ~ repetiu + desempenho', data = train_r, family = 'binomial')
print(summary(modelo2))
print(anova(modelo2, test = "Chisq"))

# Rodando o teste e avaliando a precisão: 
test_r <- subset(test_df,select = c('repetiu','desempenho','abandonou'))
resultados <- predict(modelo2,newdata = test_r, type = 'response')
resultados_ar <- ifelse(resultados > 0.5, 1, 0)
erroMedio <- mean(resultados_ar != test_r$abandonou)
print(paste('Precisão modelo reduzido:',1 - erroMedio))

# Agora, com o modelo original, para compararmos: 
resultados2 <- predict(modelo,newdata = test_df, type = 'response')
resultados2_ar <- ifelse(resultados2 > 0.5, 1, 0)
erroMedio2 <- mean(resultados2_ar != test_df$abandonou)
print(paste('Precisão modelo original:',1 - erroMedio2))


