@Echo off
SetLocal ENableDelayedExpansion
REM Auto Generated MenuBar Click File...
REM Program is Created by Kvc
Set __Main_Menu=0 
Set __Sub_Menu=0 

IF %~1 GEQ 0 If %~1 LSS 7 If %~2 EQU 0 (
	Set __Main_Menu=1
	Call List.bat 0 1 F0 "Nowy" "Otworz" "Zapisz jako" "Zamknij" 
	Set __Sub_Menu=!Errorlevel!
)
IF %~1 GEQ 7 If %~1 LSS 16 If %~2 EQU 0 (
	Set __Main_Menu=2
	Call List.bat 7 1 F0 "Nowa warstwa" "Zmien kolor" "Zmien styl" 
	Set __Sub_Menu=!Errorlevel!
)
IF %~1 GEQ 16 If %~1 LSS 24 If %~2 EQU 0 (
	Set __Main_Menu=3
	Call List.bat 16 1 F0 "Maly" "Sredni" "Duzy" 
	Set __Sub_Menu=!Errorlevel!
)
IF %~1 GEQ 24 If %~1 LSS 32 If %~2 EQU 0 (
	Set __Main_Menu=4
	Call List.bat 24 1 F0 "Autorzy" "Kontakt" "Strona WWW" 
	Set __Sub_Menu=!Errorlevel!
)

REM Preparing for Returning The User-Input...
REM Using Tunneling here...
ENDLOCAL && Set "%~3=%__Main_Menu%" && Set "%~4=%__Sub_Menu%"
Goto :EOF
REM Don't Even Think of Doing SOmething - Nasty ;)
www.thebateam.org
