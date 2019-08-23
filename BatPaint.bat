:: Programmed by hXR16F
:: hXR16F.ar@gmail.com

:: Website by Nimplex (www.batchpaint.5v.pl)

@echo off
title BatPaint
mode 70,26
setlocal EnableDelayedExpansion EnableExtensions

cmdfocus.exe /center
cmdwiz.exe setquickedit 0
cmdwiz.exe showcursor 0

for /F "tokens=*" %%n in ('type Char.chr') do (
	set "char=%%n"
)
(
	set "color=F"
	set "selColor=Jaskrawo-Bialy"
	set "style= "
	set "selStyle=!char!"
	set "selTool=Pedzel"
)

if not exist "current.bp" (
	echo;| set /P "%random%= " > "current.bp"
) else (
	call yesnobox.bat "Wykryty zostal niezapisany rysunek. Chcesz go otworzyc?" "BatPaint"
	if "!YesNo!" EQU "7" (
		echo;| set /P "%random%= " > "current.bp"
	)
)

:main
	cls
	for /F "tokens=* delims=" %%n in ('type current.bp') do batbox.exe /c 0x!color!0 %%n
	
	call MenuBar List_menu F0 _Box
	
	title Narzedzie : '!selTool!' ^| Styl : '!selStyle!' ^| Kolor : '!selColor!'
	for /F "delims=: tokens=1,2,3" %%A in ('batbox.exe /m') do (
		set Button=%%C
		set X=%%A
		set Y=%%B
	)
	
	call Check_MenuBar_Click.bat !X! !Y! _Menu_Option _Sub_menu_option
	title BatPaint : Buforowanie
	
	if "%Y%" EQU "0" (
		if "%_Menu_Option%" EQU "1" (
			if "%_Sub_menu_option%" EQU "1" (
				call yesnobox.bat "Utworzenie nowego rysunku spowoduje usuniecie starego. Czy napewno chcesz kontynuowac?" "BatPaint"
				if "!YesNo!" EQU "6" (
					echo;| set /P "%random%= " > "current.bp"
				)
			)
			if "%_Sub_menu_option%" EQU "2" (
				title BatPaint : Otwieranie
				filebrowse.exe BatPaint "" "Rysunki BatPaint (*.bp)^|*.bp" > "open"
				if exist "open" (
					for /F "tokens=*" %%I in ('type open') do (
						set "openFileName=%%~nI"
						set "openPath=%%I"
					)
					copy "!openPath!" "!cd!" >nul 2>&1
					del /F /Q "current.bp" >nul 2>&1
					ren "!openFileName!.bp" "current.bp" >nul 2>&1
				)
			)
			if "%_Sub_menu_option%" EQU "3" (
				title BatPaint : Zapisywanie
				savefiledialog.exe "Save As" "" "Rysunek BatPaint (*.bp)|*.bp" > "save"
				if exist "save" (
					for /F "tokens=*" %%I in ('type save') do (
						set "saveFileName=%%~nI"
						set "savePath=%%I"
						set "savePathOnly=%%~pI"
					)
					copy "current.bp" "!homedrive!!savePathOnly!" >nul 2>&1
					pushD "!homedrive!!savePathOnly!"
					ren "current.bp" "!saveFileName!.bp" >nul 2>&1
					popD
					echo.> "saved"
				)
			)
			if "%_Sub_menu_option%" EQU "4" (
				if not exist "saved" (
					call yesnobox.bat "Wyjscie spowoduje usuniecie narysowanego rysunku, kontynuowac?" "BatPaint"
					if "!YesNo!" EQU "6" (
						del /F /Q "current.bp" >nul 2>&1
						del /F /Q "open" >nul 2>&1
						del /F /Q "save" >nul 2>&1
						del /F /Q "saved" >nul 2>&1
						del /F /Q "temp" >nul 2>&1
						exit
					)
				) else (
					del /F /Q "current.bp" >nul 2>&1
					del /F /Q "open" >nul 2>&1
					del /F /Q "save" >nul 2>&1
					del /F /Q "saved" >nul 2>&1
					del /F /Q "temp" >nul 2>&1
					exit
				)
			)
		)
		
		if "%_Menu_Option%" EQU "2" (
			if "%_Sub_menu_option%" EQU "1" (
				echo.>> "current.bp"
			)
			if "%_Sub_menu_option%" EQU "2" (
				title BatPaint : Wybieranie koloru
				wselect.exe List_colors "" "$item" /grid /bg=#FFFFFF > temp
				for /F "tokens=*" %%i in ('type temp') do set "selColor=%%i"
				if /I "!selColor!" EQU "Czarny" set "color=0"
				if /I "!selColor!" EQU "Niebieski" set "color=1"
				if /I "!selColor!" EQU "Zielony" set "color=2"
				if /I "!selColor!" EQU "Blekitny" set "color=3"
				if /I "!selColor!" EQU "Czerwony" set "color=4"
				if /I "!selColor!" EQU "Purpurowy" set "color=5"
				if /I "!selColor!" EQU "Zolty" set "color=6"
				if /I "!selColor!" EQU "Bialy" set "color=7"
				if /I "!selColor!" EQU "Szary" set "color=8"
				if /I "!selColor!" EQU "Jasno-Niebieski" set "color=9"
				if /I "!selColor!" EQU "Jasno-Zielony" set "color=A"
				if /I "!selColor!" EQU "Jasno-Blekitny" set "color=B"
				if /I "!selColor!" EQU "Jasno-Czerwony" set "color=C"
				if /I "!selColor!" EQU "Jasno-Purpurowy" set "color=D"
				if /I "!selColor!" EQU "Jasno-Zolty" set "color=E"
				if /I "!selColor!" EQU "Jaskrawo-Bialy" set "color=F"
			)
			if "%_Sub_menu_option%" EQU "3" (
				title BatPaint : Wybieranie stylu
				wselect.exe List_styles "" "$item" /grid /bg=#FFFFFF > temp
				for /F "tokens=*" %%i in ('type temp') do set "selStyle=%%i"
				if /I "!selStyle!" EQU "Domyslny" (
					set "style= "
					set "selStyle=!char!"
				) else (
					set "style=!selStyle!"
				)
			)
			rem if "%_Sub_menu_option%" EQU "4" (
			rem 	title BatPaint : Wybieranie narzedzia
			rem 	wselect.exe List_tools "" "$item" /grid /bg=#FFFFFF > temp
			rem 	for /F "tokens=*" %%i in ('type temp') do set "selTool=%%i"
			rem )
		)
		
		if "%_Menu_Option%" EQU "3" (
			if "%_Sub_menu_option%" EQU "1" mode 70,26 && cmdfocus.exe /center
			if "%_Sub_menu_option%" EQU "2" mode 90,36 && cmdfocus.exe /center
			if "%_Sub_menu_option%" EQU "3" mode 110,46 && cmdfocus.exe /center
		)
		
		if "%_Menu_Option%" EQU "4" (
			if "%_Sub_menu_option%" EQU "1" start Developers.vbs
			if "%_Sub_menu_option%" EQU "2" start Contact.vbs
			if "%_Sub_menu_option%" EQU "3" start www.batchpaint.5v.pl
		)
	) else (
		if exist "saved" del /F /Q "saved"
		if "!style!" EQU " " (
			echo;| set /P "%random%=/c 0x!color!0 /g !X! !Y! /d "!style!" ">> "current.bp"
		) else (
			echo;| set /P "%random%=/c 0x0!color! /g !X! !Y! /d "!style!" ">> "current.bp"
		)
	)
	
	goto :main