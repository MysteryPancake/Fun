import tensorflow as tf
from tensorflow import keras
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image

def loadImage(path):
	return np.asarray(Image.open(path, 'r').convert('RGB').resize((128, 128))) / 255

def compareImages(img1, img2, rows=10, cols=5):
	fig, axes = plt.subplots(nrows=rows, ncols=cols * 2, figsize=(12, 12))
	index = 0
	for i in range(rows):
		for j in range(cols):
			if index < len(img1):
				axes[i, j].imshow(np.clip(img1[index], 0, 1))
				axes[i, cols + j].imshow(np.clip(img2[index], 0, 1))
				index += 1
	plt.tight_layout()
	plt.show()

model = keras.models.Sequential([
	# Random 64 x 64 RGB inputs
	keras.Input(shape=(128, 128, 3)),

	keras.layers.Conv2D(32, kernel_size=(5, 5), strides=1, padding='same', activation='relu'),
	keras.layers.MaxPooling2D(pool_size=(2, 2)),

	#keras.layers.Conv2DTranspose(32, kernel_size=5, strides=2, padding='same', activation='relu'),

	keras.layers.Conv2D(32, kernel_size=(3, 3), strides=1, padding='same', activation='relu'),
	keras.layers.MaxPooling2D(pool_size=(2, 2)),

	keras.layers.Conv2DTranspose(32, kernel_size=5, strides=2, padding='same', activation='relu'),
	#keras.layers.Dense(256, activation='relu'),
	#keras.layers.Dense(512, activation='relu'),
	keras.layers.Conv2DTranspose(32, kernel_size=3, strides=2, padding='same', activation='relu'),
	

	keras.layers.Conv2D(3, kernel_size=(3, 3), strides=1, padding='same'),
	# 32 x 32 RGB output
])
model.compile(optimizer='adam', loss='mse')
#model.summary()

batch_size = 128
epochs = 512
num_samples = 12

source = np.empty((num_samples, 128, 128, 3))
target = np.empty((num_samples, 128, 128, 3))

for i in range(num_samples):
	source[i] = loadImage(f"customdataset/dark/{i}.jpg")
	target[i] = loadImage(f"customdataset/light/{i}.jpg")

model.fit(source, target, batch_size=batch_size, epochs=epochs)
preds = model.predict(source)

cap = cv.VideoCapture(0)
while True:
	ret, img = cap.read()

	og = cv.cvtColor(cv.resize(img, (128, 128)), cv.COLOR_BGR2RGB) / 255

	pred = model.predict(np.array([og]))[0]

	joined = np.concatenate((og, pred), axis=1)
	cv.imshow('Webcam AI Demo', cv.resize(joined, (1024, 512)))
	if cv.waitKey(1) == ord('q'):
		break
cap.release()
cv.destroyAllWindows()