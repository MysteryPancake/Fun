import tensorflow as tf
from tensorflow import keras
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
import os

def loadImage(path):
	return np.asarray(Image.open(path, 'r').convert('RGB')) / 255

def tileSplit(img, rows=32, cols=32):
	tiles = []
	for y in range(0, img.shape[0], cols):
		height = y + cols
		if height > img.shape[0]:
			break
		for x in range(0, img.shape[1], rows):
			width = x + rows
			if width > img.shape[1]:
				break
			tiles.append(img[y:height, x:width])
	return tiles

def tileCombine(shape, tiles):
	result = np.empty(shape)
	x = y = 0
	for tile in tiles:
		result[y:y+tile.shape[0], x:x+tile.shape[1]] = tile
		x += tile.shape[1]
		if x >= shape[1]:
			y += tile.shape[0]
			x = 0
	return result

# TODO: STEAL STRUCTURE FROM https://github.com/OpenImageDenoise/oidn/blob/master/training/model.py

model = keras.models.Sequential([
	# Random 32 x 32 RGB inputs
	keras.Input(shape=(32, 32, 3)),

	keras.layers.Conv2D(128, kernel_size=7, strides=1, padding='same', activation='relu'),
	keras.layers.MaxPooling2D(pool_size=2),

	keras.layers.Conv2D(128, kernel_size=5, strides=1, padding='same', activation='relu'),
	keras.layers.MaxPooling2D(pool_size=2, strides=2),

	keras.layers.Conv2D(128, kernel_size=5, strides=1, padding='same', activation='relu'),
	keras.layers.MaxPooling2D(pool_size=2, strides=2),

	#keras.layers.Dense(1024, activation='relu'),
	keras.layers.Conv2DTranspose(128, kernel_size=3, strides=2, padding='same', activation='relu'),
	keras.layers.Conv2DTranspose(128, kernel_size=5, strides=2, padding='same', activation='relu'),
	keras.layers.Conv2DTranspose(128, kernel_size=7, strides=2, padding='same', activation='relu'),

	keras.layers.Conv2D(3, kernel_size=3, strides=1, padding='same', activation='sigmoid'),
	# 32 x 32 RGB output
])
model.compile(optimizer='adam', loss='mae')
#model.summary()

batch_size = 128
epochs = 4
num_samples = 40000

# Try to train the AI to remove noise
(x_train, y_train), (x_test, y_test) = keras.datasets.cifar10.load_data()
target = x_train[:num_samples] / 255

# Add noise
noise_factor = np.random.uniform(0.5, 1, (num_samples, 1, 1, 3))
noise = np.random.uniform(noise_factor, 1, target.shape)
source = np.clip(target * noise, 0, 1)

model.fit(source, target,
	batch_size=batch_size,
	epochs=epochs,
	steps_per_epoch=num_samples // batch_size
)

cap = cv.VideoCapture(0)
while True:
	ret, img = cap.read()

	# Half image size
	#img = cv.resize(img, (0, 0), fx=0.5, fy=0.5)
	# Add 50% noise
	img = (cv.cvtColor(img, cv.COLOR_BGR2RGB) / 255) * np.random.uniform(0.5, 1, img.shape)

	pred = tileCombine(img.shape, model.predict(np.array(tileSplit(img))))

	joined = np.concatenate((img, pred), axis=1)
	cv.imshow('Webcam AI Demo', joined)
	if cv.waitKey(1) == ord('q'):
		break
cap.release()
cv.destroyAllWindows()