# Copyright 2019 Cleuton Sampaio.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder, StandardScaler
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
import numpy as np

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

def build_model(numAttribs,numClasses):
	# Criação do modelo básico
	model = Sequential()
	model.add(Dense(8, input_dim=numAttribs, activation='relu'))
	model.add(Dense(numClasses, activation='softmax'))
	model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])
	return model

def new_samples():
    # Setosa (1,0,0), Versicolor (0,1,0) e Virgínica (0,0,1)
    new_iris_samples = np.array(
        [[5.1, 3.3, 1.7, 0.5],
         [5.9, 3.0, 4.2, 1.5],
         [6.9, 3.1, 5.4, 2.1]], dtype=np.float32)
    return new_iris_samples

def main():
    X_train, X_test, y_train, y_test = prepare_dataset()
    model = build_model(len(X_train[0]),len(y_train[0]))
    model.fit(X_train, y_train, epochs=150, batch_size=10)
    perda,acuracia = model.evaluate(X_test, y_test)
    print('Acurácia: %.2f' % (acuracia*100))

    # Salva o modelo treinado
    model.save("/tmp/iris.h5")

    # Predições
    new_data = new_samples()
    predictions = model.predict(new_data)
    rounded = [[np.round(float(i), 0) for i in amostra] for amostra in predictions]
    print(rounded)

if __name__ == '__main__':
    main()

