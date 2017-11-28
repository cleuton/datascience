
from pyspark.sql import SparkSession
from pyspark.sql import Row
import sys

sc = SparkSession.builder.appName("avgsql").getOrCreate()

entrada = sc.sparkContext.textFile(sys.argv[1])
filterDD = entrada.filter(lambda l: not l.startswith('id'))   

arquivo = filterDD.map(lambda l: l.split(","))
colunas = arquivo.map(lambda p: Row(
    regiao=repr(p[3]) + repr(p[4]), 
    valor=float(p[6])
    )
)

df = sc.createDataFrame(colunas)
df.registerTempTable("medicoes")

medias = sc.sql("SELECT regiao, avg(valor) as media FROM medicoes group by regiao")
medias.show()
