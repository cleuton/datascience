![](../logo_fundo_branco.png)
# O seu Hub de Datascience, Machine Learning e IA
[*Cleuton Sampaio*](https://github.com/cleuton)

# Deep learning com Keras

[**Keras**](https://keras.io/) é uma API para *Deep learning* que funciona com vários frameworks rodando como *backend*. É mais comumente utilizada com [**Tensorflow**](https://www.tensorflow.org/), mas eu mesmo já a utilizei com o [**CNTK**](https://docs.microsoft.com/en-us/cognitive-toolkit/).

O objetivo dessa demonstração é mostrar como criar um modelo simples de *Deep learning* com **Keras**. 

## Deep learning

Se quiser saber mais sobre [**Deep Learning**](https://pt.wikipedia.org/wiki/Aprendizagem_profunda) eu recomendo o meu livro [**Neural Java**](https://github.com/cleuton/neuraljava). 

## Iris

O [**dataset iris**](https://archive.ics.uci.edu/ml/datasets/iris) é um dos mais conhecidos de quem está aprendendo redes neurais. Ele contém 3 classes de flores de íris, com 50 amostras de cada. Cada classe é linearmente separável das outras duas, mas elas não são linearmente separáveis individualmente. 

As amostras possuem os atributos: 
1. sepal length in cm 
2. sepal width in cm 
3. petal length in cm 
4. petal width in cm 
5. class: 
- Iris Setosa 
- Iris Versicolour 
- Iris Virginica

Eis uma amostra do dataset original: 

```
5.1,3.5,1.4,0.2,Iris-setosa
4.9,3.0,1.4,0.2,Iris-setosa
4.7,3.2,1.3,0.2,Iris-setosa
...
7.0,3.2,4.7,1.4,Iris-versicolor
6.4,3.2,4.5,1.5,Iris-versicolor
6.9,3.1,4.9,1.5,Iris-versicolor
...
6.3,3.3,6.0,2.5,Iris-virginica
5.8,2.7,5.1,1.9,Iris-virginica
7.1,3.0,5.9,2.1,Iris-virginica
```

Note que o quinto atributo é a classe ou rótulo de cada amostra e que, para treinar um modelo de rede neural, precisamos transformá-lo em algo como [**one-hot-encoding**](https://hackernoon.com/what-is-one-hot-encoding-why-and-when-do-you-have-to-use-it-e3c6186d008f).

## Criando o ambiente

Eu uso o [**Anaconda**](https://www.anaconda.com/) para criar e gerenciar ambientes virtuais Python. No repositório, há um arquivo [**conda-env.yml**](./conda-env.yml) que pode ser utilizado para criar o ambiente:

```
conda env create -f conda-env.yml
conda activate kerastraining
```
Com o ambiente criado e ativado, você pode executar os exemplos.

## Treinando o modelo 

Execute o script [**run-iris-keras.py**](./run-iris-keras.py) para carregar o dataset, preparar, construir e treinar o modelo. Ele o salva para posterior uso em predições. 

O script também testa e roda predições: 

```
Epoch 150/150
75/75 [==============================] - 0s 55us/sample - loss: 0.4367 - acc: 0.9467
75/75 [==============================] - 0s 246us/sample - loss: 0.4021 - acc: 1.0000
Acurácia: 100.00
[[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
```
Analise o código do script que é bem interessante. Eu preparo o dataset nesta parte: 

```
def prepare_dataset():
    iris = load_iris()
    attribs = iris['data']
    classes = iris['target']
    names = iris['target_names']
    feature_names = iris['feature_names']

    # Convertendo classes para One hot encoding
    encoder = OneHotEncoder()
    iris_encoded = encoder.fit_transform(classes[:, np.newaxis]).toarray()

    # Dividindo dataset em treino e teste
    X_train, X_test, y_train, y_test = train_test_split(
        attribs, iris_encoded, test_size=0.5, random_state=2)

    return X_train, X_test, y_train, y_test
```

E já retorno 4 listas, duas de treino e duas de teste. Cada dupla contém os atributos ("X_...") e os rótulos ("y_..."). Duas são para treinar o modelo e duas para avaliar. Eu usei 3 pacotes do [**Scikit-learn**](https://scikit-learn.org) para isto: **sklearn.datasets**, **sklearn.model_selection** e **sklearn.preprocessing**.

Depois, eu construo um modelo simples, com 1 camada oculta: 

```
def build_model(numAttribs,numClasses):
	# Criação do modelo básico
	model = Sequential()
	model.add(Dense(8, input_dim=numAttribs, activation='relu'))
	model.add(Dense(numClasses, activation='softmax'))
	model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])
	return model
```

E, finalmente, treino e avalio, salvando o modelo (em formato [**HDF5**](https://www.hdfgroup.org/solutions/hdf5/)): 

``` 
def main():
    X_train, X_test, y_train, y_test = prepare_dataset()
    model = build_model(len(X_train[0]),len(y_train[0]))
    model.fit(X_train, y_train, epochs=150, batch_size=10)
    perda,acuracia = model.evaluate(X_test, y_test)
    print('Acurácia: %.2f' % (acuracia*100))

    # Salva o modelo treinado
    model.save("/tmp/iris.h5")
```

Para executar inferências eu crio 3 registros com suas respectivas classes e monto uma lista de listas com eles: 

```
def new_samples():
    # Setosa (1,0,0), Versicolor (0,1,0) e Virgínica (0,0,1)
    new_iris_samples = np.array(
        [[5.1, 3.3, 1.7, 0.5],
         [5.9, 3.0, 4.2, 1.5],
         [6.9, 3.1, 5.4, 2.1]], dtype=np.float32)
    return new_iris_samples
```

Então, é só rodar a inferência e ver o resultado: 

```
    # Predições
    new_data = new_samples()
    predictions = model.predict(new_data)
    rounded = [[np.round(float(i), 0) for i in amostra] for amostra in predictions]
    print(rounded)
```

O resultado é a saída de cada neurônio da camada de saída. Como usei a função [**SOFTMAX**](https://en.wikipedia.org/wiki/Softmax_function), o retorno será a probabilidade de cada neurônio estar "ligado" (igual a 1). Podemos arredondar e veremos o resultado correto: 

```
[[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
```

Se, em vez do método **predict()** usarmos o **predict_classes()** ele retornará o número da classe diretamente. Eu fiz isso no outro script.

## Usando o modelo treinado para inferências

Isso é o processamento "em produção", ou seja, pegamos o modelo treinado (HDF5) e o utilizamos para inferir a classe de novos dados. Eu faço isso no outro script: [**run-iris-inference.py**](./run-iris-inference.py):

```
import tensorflow as tf
import numpy as np
def main():
    loaded_model = tf.keras.models.load_model('/tmp/iris.h5')
    loaded_model.summary()
    # Setosa (0), Versicolor (1) e Virgínica (2)
    new_iris_samples = np.array(
        [[5.1, 3.3, 1.7, 0.5],
         [5.9, 3.0, 4.2, 1.5],
         [6.9, 3.1, 5.4, 2.1]], dtype=np.float32)
    resultado = loaded_model.predict_classes(new_iris_samples) 
    print(resultado) 

if __name__ == '__main__':
    main()
```

Eis o resultado da inferência: 

```
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
dense (Dense)                (None, 8)                 40        
_________________________________________________________________
dense_1 (Dense)              (None, 3)                 27        
=================================================================
Total params: 67
Trainable params: 67
Non-trainable params: 0
_________________________________________________________________
[0 1 2]
```

Eu imprimi o sumário do modelo, mas isso não é necessário. O resultado da inferência é o array do final, indicando que o modelo previu corretamente as classes. 




