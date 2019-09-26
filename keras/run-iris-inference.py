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