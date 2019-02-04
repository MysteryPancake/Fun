import time

t = time.time() + 1.5
x = 100
print("hello")
time.sleep(1)
while time.time() < t:
  for i in range(0, x):
    if i < x * 0.5:
      print(" " * i + "*")
    else:
      print(" " * (x - i) + "*")
    time.sleep(0.01)
print("what is your name?")
input()
print("disgusting")