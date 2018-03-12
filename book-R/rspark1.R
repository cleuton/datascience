library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
sparkR.session(master = "local[*]", sparkConfig = list(spark.driver.memory = "2g"))

ds <- read.csv("medicoes.csv", header = TRUE)
spdf <- as.DataFrame(ds)
printSchema(spdf)
print(head(summarize(groupBy(spdf, spdf$latitude,spdf$longitude), avg(spdf$quality))))
