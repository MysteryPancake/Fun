import tensorflow as tf
from tensorflow import keras
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image

def loadImage(path):
	return np.asarray(Image.open(path, 'r').convert('RGB')) / 255

def compareImages(img1, img2, rows=10, cols=5):
	fig, axes = plt.subplots(nrows=rows, ncols=cols * 2, figsize=(12, 12))
	index = 0
	for i in range(rows):
		for j in range(cols):
			if index < len(img1):
				axes[i, j].imshow(np.clip(img1[index], 0, 1))
			if index < len(img2):
				axes[i, cols + j].imshow(np.clip(img2[index], 0, 1))
			index += 1
	plt.tight_layout()
	plt.show()

model = keras.models.Sequential([
	# Random 32 x 32 RGB inputs
	keras.Input(shape=(32, 32, 3)),
	keras.layers.Conv2D(128, kernel_size=(3, 3), strides=1, padding='same', activation='relu'),
	keras.layers.Conv2D(64, kernel_size=(3, 3), strides=1, padding='same', activation='relu'),
	keras.layers.Conv2DTranspose(64, kernel_size=3, strides=1, padding='same', activation='relu'),
	keras.layers.Conv2DTranspose(128, kernel_size=3, strides=1, padding='same', activation='relu'),
	keras.layers.Conv2D(3, kernel_size=(3, 3), strides=1, padding='same'),
	# 32 x 32 RGB output
])
model.compile(optimizer='adam', loss='mae')
#model.summary()

batch_size = 64
epochs = 512
num_samples = 64

# Try to overfit the AI on training data
smile = loadImage('smile.png')
smile2 = loadImage('face.png')

noise = np.random.random((num_samples, 32, 32, 3))
source = np.repeat([smile], num_samples, axis=0) * noise
target = np.repeat([smile2], num_samples, axis=0)

model.fit(source, target,
	batch_size=batch_size,
	epochs=epochs,
	steps_per_epoch=num_samples // batch_size
)
preds = model.predict(source)
compareImages(source, preds)