# Amostra de filhos em idade escolar por residência: 
library('moments')

filhos <- c(3, 2, 2, 2, 1, 2, 2, 2, 2, 3, 1, 2, 1, 2, 2, 0, 1, 2, 2, 1, 2, 1, 1,
            2, 2, 3, 2, 1, 2, 3, 4, 1, 1, 2, 1, 1, 1, 2, 3, 0, 2, 2, 1, 2, 3, 3,
            2, 2, 3, 2)

media = mean(filhos)
desvio = sd(filhos)
print(paste('Média:',media))
print(paste('Desvio:',desvio))
print(paste('Assimetria:',skewness(filhos)))
print(paste('Curtose:',kurtosis(filhos)))
print(summary(filhos))

# Plotando a distribuição normal e o intervalo de confiança:
x <- seq(-3,3,length=500)
y <- dnorm(x,mean=0, sd=1)
plot(x,y, type="l", lwd=2, main = 'Distribuição normal padrão')

# Calculando os limites do intervalo de confiança de 95%:
z1 <-qnorm(0.025)
z2 <- qnorm(0.975)
lines(c(0,0),c(0,dnorm(0)))
lines(c(z1,z1),c(0,dnorm(z1)))
lines(c(z2,z2),c(0,dnorm(z2)))

# Calculando a margem de erro: 
E <- z2 * (desvio / sqrt(length(filhos)))
print(paste('Margem de erro:',E))
minf <- media - E
msup <- media + E
print(sprintf('A média de filhos está entre: %f e %f com 95%% de confiança',minf,msup))

# Agora com distribuição T de Student:

graus = length(filhos) - 1 # Graus de liberdade
print(paste('Graus de liberdade:',graus))

# Plotando a distribuição T de Student e o intervalo de confiança:
x <- seq(-3,3,length=500)
y <- dt(x,df=graus)
plot(x,y, type="l", lwd=2, main = 'Distribuição T de Student')


t1 <-qt(0.025,df=graus)
t2 <- qt(0.975,df=graus)
lines(c(0,0),c(0,dt(0,df=graus)))
lines(c(t1,t1),c(0,dt(t1,df=graus)))
lines(c(t2,t2),c(0,dt(t2,df=graus)))

E2 <- t2 * (desvio / sqrt(length(filhos)))
print(paste('Margem de erro:',E2))
minf2 <- media - E2
msup2 <- media + E2
print(sprintf('A média de filhos está entre: %f e %f com 95%% de confiança',minf2,msup2))

# Teste de hipótese

lote <- c(58.5, 60.1, 60.02, 57.4, 60.3, 55.4, 58.2, 59.8, 54.3, 60.4, 60.7, 60.1, 55.6, 57.1, 60.0, 
          60.7, 60.3, 56.7,  57.9, 59.01)
print(summary(lote))

graus = length(lote) - 1 # Graus de liberdade
print(paste('Graus de liberdade:',graus))
tq1 <-qt(0.05,df=graus) # teste unicaudal à esquerda por isso usamos 0.05 para 95%
x <- seq(-3,3,length=500)
y <- dt(x,df=graus)
plot(x,y, type="l", lwd=2, main = 'Distribuição T de Student - queijos')
lines(c(0,0),c(0,dt(0,df=graus)))
lines(c(tq1,tq1),c(0,dt(tq1,df=graus)))

# Calculando o T Score da nossa amostra:
ta <- (mean(lote) - 60) / (sd(lote) / sqrt(length(lote)))
if (ta < tq1) {
  print('Rejeitamos a hipótese nula')
} else {
  print('Não rejeitamos a hipótese nula')
}

# Agora usando o p-value:
pvalue <- pt(ta, 19)
if (pvalue < 0.05) {
  print('Rejeitamos a hipótese nula pelo valor-p')
} else {
  print('Não rejeitamos a hipótese nula pelo valor-p')
}