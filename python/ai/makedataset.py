import cv2 as cv
import math
import time

dark = True
index = 0
nextTime = 0
cap = cv.VideoCapture(0)
while True:
	ret, img = cap.read()
	cv.imshow('Webcam Demo', img)
	key = cv.waitKey(1)
	if key == ord(' ') and nextTime - time.time() < 0:
		print('Saved')
		nextTime = time.time() + 2
		if dark:
			path = f'customdataset/dark/{math.floor(index)}.jpg'
		else:
			path = f'customdataset/light/{math.floor(index)}.jpg'
		if cv.imwrite(path, img):
			print('Saved')
		else:
			print('Error')
		dark = not dark
		index += 0.5
	elif key == ord('q'):
		break
cap.release()
cv.destroyAllWindows()