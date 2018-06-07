@echo off
set /p test="Paste the link to the (small) profile pic here - "
set test=%test:s150x150/=%
start "" %test%