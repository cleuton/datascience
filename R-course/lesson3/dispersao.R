# Dispersao

turma1 <- c(75.02786847, 56.51450656, 55.57517955, 62.00893933,
            82.82022277, 91.78076684, 71.53028442, 82.22315417,
            71.14621041, 76.27644453)
print(paste('Média da turma 1:',mean(turma1)))
print(paste('Mediana da turma 1:',median(turma1)))

turma2 <- c(63.96213546,  51.00946728,  54.48449137,  53.62955058,
            61.62138863,  59.99119596,  57.61297576,  62.52220793,
            64.54041384,  63.95477107)
print(paste('Média da turma 2:',mean(turma2)))
print(paste('Mediana da turma 2:',median(turma2)))

hist(turma1)
hist(turma2)

# Amplitude:

ampTurma1 <- max(turma1) - min(turma1)
ampTurma2 <- max(turma2) - min(turma2)

print(paste('Amplitude da turma 1:',ampTurma1))
print(paste('Amplitude da turma 2:',ampTurma2))

# Variância:

varTurma1 <- var(turma1) # amostra
varTurma2 <- var(turma2) # amostra

print(paste("Variância amostral da turma 1:",varTurma1))
print(paste("Variância amostral da turma 2:",varTurma2))

vPopT1 <- mean((turma1-mean(turma1))^2)
vPopT2 <- mean((turma2-mean(turma2))^2)
print(paste("vt1:",vt1))

print(paste("Variância populacional da turma 1:",vPopT1))
print(paste("Variância populacional da turma 2:",vPopT2))

# Desvio padrão:

dTurma1 <- sd(turma1) # amostral
dTurma2 <- sd(turma2) # amostral
dPopT1 <- sqrt(mean((turma1-mean(turma1))^2)) # populacional
dPopT2 <- sqrt(mean((turma1-mean(turma2))^2)) # populacional
               


