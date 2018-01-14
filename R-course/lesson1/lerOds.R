library('readODS')
library('tidyverse')
data <- read_ods('mod-preditivo.ods', sheet=2,col_names = TRUE,range='a1:b30',col_types=NA)
print(data)
df <- type_convert(data,trim_ws=TRUE,col_types = cols(Pesos=col_integer(),Alturas=col_double()),locale = locale(decimal_mark = ","))
str(df)
y <- df$Pesos
x <- df$Alturas
model <- lm(y ~ x)
summary(model)
df2 <- data.frame(x=c(1.40,1.90))
pesos2 <- predict(model,newdata = df2)
head(pesos2)
plot(x, y)
lines(df2$x,pesos2,col="red")


