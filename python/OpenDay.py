print("hello")
print("What is your name?")
x = input()
print("Hello,", x)
print("Is life treating you well?")
y = input()
while "bye" not in y:
 if "school" in y:
    print("What's wrong with school?")
    y = input()
 elif "parents" in y:
    print("what's wrong with your parents")
    y = input()
 else:
     print("Tell me more about yourself")
     y = input()