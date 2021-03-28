@echo off
set /p file="Enter filename without .java: "
javac %file%.java
java %file%
