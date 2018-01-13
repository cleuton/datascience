# Histograma:
# Itens comprados em nossa loja na última semana, por pedido:
compras <- c(1,1,1,3,3,5,5,6,6,6,6,7,8,8,9,9,9,9,10,10,10,11,13,14,14,15,15,15,15)
print(summary(compras))
print(paste('Desvio amostral:',sd(compras)))

# Histograma padrão:
print(hist(compras))

# Histograma com classes aproximadamente de igual amplitude: 
print(hist(compras, breaks = c(0,3,6,7,10,13,15), freq = TRUE))

# Cálculo da assimetria (Skewness):
# ---> É necessário instalar o pacote 'moments". Digite na janela console: 
# install.packages('moments')
library(moments)
print(paste('Assimetria:',skewness(compras)))

# Curtose (Kurtosis): 
print(paste('Curtose:',kurtosis(compras)))

# Gerando variável aleatória com base na distribuição normal de probabilidades:
numeros <- rnorm(500)
hist(numeros,probability = TRUE)
print(lines(density(numeros)))
print(summary(numeros))
print(paste('Assimetria',skewness(numeros)))
print(paste('Curtose',kurtosis(numeros)))
print(paste('Desvio padrão',sd(numeros)))

# Plotando a densidade das compras: 
hist(compras, breaks = c(0,3,6,7,10,13,15), probability = TRUE)
print(lines(density(compras)))
