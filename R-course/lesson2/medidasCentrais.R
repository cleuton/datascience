# Vamos criar um vetor com pesos dos alunos:
a <- c(52,52,54,56,57,60,61,65,70,120)

# Exibindo o vetor inteiro (todas as posições):
print(a)

# Exibindo apenas a primeira posição (o peso da primeira pessoa: 52):
print(a[1])

# Exibindo apenas a décima posição (o peso da décima pessoa: 120):
print(a[10])

# Exibindo a quantidade de posições do vetor (10):
print(length(a))

# Calculando a Média manualmente (soma dos pesos / quantidade de pessoas): 
media <- sum(a) / length(a)
print(media)

# Usando a função "mean()":
print(mean(a))

# Calculando a mediana dos pesos: 
mediana <- median(a)
print(mediana)

# Moda (R não tem uma função nos pacotes padrões): 
# Criando uma função para calcular a moda: 
calcMode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Invocando a função e calculando a moda do vetor (54): 
moda <- calcMode(a)
print(moda)

# Mostrando um histograma com a distribuição dos pesos: 
print(hist(a))
