@Echo off
SetLocal ENableDelayedExpansion

REM Checking important files...
FOR %%A In (Getlen.bat batbox.exe GetDim.bat List.bat) DO (IF Not Exist "%%A" (Echo. MenuBar Function, Error... File [%%A] is Missing...))
Set _Ver=1.0

:: The following Function is created by kvc...don't modify it...if you don't know what are you doing...
:: it takes following arguments...
:: it is the ver.1.0 of MenuBar function... #kvc

:: It will allow you to create Awesome batch programs with menuBars and Much more...
:: Get it from www.thebateam.org, you'll find more awesome stuff like this.

:: :)

:: [%1 = File, To Load MenuBar Items]
:: [%2 = Color of the MenuBar]

rem #kvc

rem :: Visit https://batchprogrammers.blogspot.com for more extensions / plug-ins like this.... :]
rem #TheBATeam

If /i "%~1" == "" (goto :help)
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "help" (goto :help)
If /i "%~1" == "-help" (goto :help)

If /i "%~1" == "ver" (echo.%_Ver%&&goto :eof)

If /i "%~2" == "" (goto :help)

REM Setting-up variables...
Set "_File=%~1"
Set "_Color=%~2"
set _Count=0
Set X=0
Set Y=0
Set _Total_len=0
Set _Script=Check_MenuBar_Click.bat

REM Generating Dummy Click file...
Echo.@Echo off>"!_Script!"
Echo.SetLocal ENableDelayedExpansion>>"!_Script!"
Echo.REM Auto Generated MenuBar Click File...>>"!_Script!"
Echo.REM Program is Created by Kvc>>"!_Script!"
Echo.Set __Main_Menu=0 >>"!_Script!"
Echo.Set __Sub_Menu=0 >>"!_Script!"
Echo.>>"!_Script!"

REM Getting some details about console...
Call GetDim _Lines _Columns

REM Filling the first line as in MenuBars...
For /L %%A In (1,1,!_Columns!) Do (Set "_MenuBG=!_MenuBG! ")

REM Loading The Raw Data From Database to Current Environment...
For /F "EOL=# Usebackq Tokens=*" %%A In ("%_File%") Do (
	Set _Temp=%%A

	If /I "!_Temp:~0,1!" == "$" (
			REM It Is Sub Menu of Previous MenuItem...
			REM Checking Sub menu options...
			FOR %%X in (!_Count!) DO (Set "_Menu_%%X_Sub=!_Menu_%%X_Sub!"%%A" ")
		) ELSE (
		REM It Is Menu Item...
		Set /A _Count+=1
		Set "_Menu_!_Count!=%%A"

		REM Getting size of Menu option...
		Call Getlen ".%%A.."
		Set Len=!Errorlevel!
		Set /A _Total_len+=!Len!

		REM Saving one line MenuBar options...
		Set "_MenuBar=!_MenuBar!/g !X! !Y! /d " %%A ^|" "

		Set _Menu_!_Count!_X=!X!
		Set /A X+=!Len!
		Set /A _Menu_!_Count!_X_End=!X!
		Set _Menu_!_Count!_Y=!Y!

		)
)

REM Creating Middle Of Auto Generated Script...
REM Generating an auto Script for clicking on MenuBar...
Set /A _Y_=!Y! + 1

For /L %%A In (1,1,!_Count!) Do (
	REM For the Positions Detection...
	
	IF /I "!_Menu_%%A_Sub!" NEQ "" (
		Echo.IF %%~1 GEQ !_Menu_%%A_X! If %%~1 LSS !_Menu_%%A_X_End! If %%~2 EQU !_Menu_%%A_Y! ^(>>"!_Script!"
		Echo.	Set __Main_Menu=%%A>>"!_Script!"
		Echo.	Call List.bat !_Menu_%%A_X! !_Y_! !_Color! !_Menu_%%A_Sub:$=!>>"!_Script!"
		Echo.	Set __Sub_Menu=^^!Errorlevel^^!>>"!_Script!"
		Echo.^)>>"!_Script!"
	) ELSE (
		Echo.IF %%~1 GEQ !_Menu_%%A_X! If %%~1 LEQ !_Menu_%%A_X_End! If %%~2 EQU !_Menu_%%A_Y! ^(Set __Main_Menu=%%A^& Set __Sub_Menu=0^)>>"!_Script!"
	)
)

REM Completing the Auto Generated Script...
Echo.>>"!_Script!"
Echo.REM Preparing for Returning The User-Input...>>"!_Script!"
Echo.REM Using Tunneling here...>>"!_Script!"
Echo.ENDLOCAL ^&^& Set "%%~3=%%__Main_Menu%%" ^&^& Set "%%~4=%%__Sub_Menu%%">>"!_Script!"
Echo.Goto :EOF>>"!_Script!"
Echo.REM Don't Even Think of Doing SOmething - Nasty! ;)>>"!_Script!"
Echo.www.thebateam.org>>"!_Script!"
batbox /g 0 0 /c 0x%_Color% /d "!_MenuBG!" !_MenuBar! /c 0x07
Goto :EOF

:Help
Echo.
Echo. This function helps in Adding a little GUI effect into your batch program...
echo. It Prints simple MenuBar on cmd console at Top X=0 Y=0; Co-ordinates (Default)
Echo. You Need to provide a Text File, Containing The MenuBar Options And Their Sub
Echo. Options, (Which are starting By '$' Sign in the File.) [See Example @ Bottom]
Echo.
Echo. After printing, it Generates a 'Check_MenuBar_Click.Bat' Script For Verifying
Echo. Whether, User has clicked On Any Menu Option or Not. 
Echo. You can use this file to Simply interacting with the MenuBar Easily. [See E.g]
Echo. 
Echo. IF 'X' is clicked, or Pressed ESC From Keyboard... then it will return 0 in 
Echo. the 'Errorlevel' Variable.
echo.
echo. Syntax: call MenuBar [File] [Color]
echo. Syntax: call MenuBar [help ^| /^? ^| -h ^| -help]
echo. Syntax: call MenuBar ver
echo.
echo. Where:-
Echo. File		= Database File of the MenuBar [Contains Menu_options+Sub_Menu]
Echo. Color		= Color of the MenuBar [Hex Code: 0F,08,07 etc.]
echo. ver		= Version of MenuBar function
Echo.
Echo. Example:-
Echo. Call MenuBar Menu_Options.txt F0
Echo.
Echo. Where, Menu_Options - File should be as Follows:
Echo. -------------------------------------------------------------------------------
Echo. # All Lines, after '#' Are Comments... And, after '$' Are Sub_Menu options.
Echo. Menu 1
Echo. $Menu 1 - Sub Menu 1
Echo. $Menu 1 - Sub Menu 2
Echo. $Menu 1 - Sub Menu 3
Echo. Menu 2
Echo. $Menu 2 - Sub Menu 1
Echo. $Menu 2 - Sub Menu 2
Echo. Menu 3
Echo. $Menu 3 - Sub Menu 1
Echo. # Quite simple... Isn't it?
Echo. -------------------------------------------------------------------------------
Echo. 
Echo. Demo:
Echo. A Short And Simple Batch Program would be as:
Echo. :Top
Echo. cls
Echo. call MenuBar File f0
Echo.
Echo. :mouse
Echo. REM Enabling Mouse Interaction with Cmd... Using 'Batbox'
Echo. For /F "Delims=: Tokens=1,2,3" %%%%A in ('Batbox.exe /m') Do (
Echo.	set Button=%%%%C
Echo.	set X=%%%%A
Echo.	set Y=%%%%B
Echo.	)
Echo.
Echo. Call Check_MenuBar_Click.bat %%X%% %%Y%% _Menu_Option _Sub_menu_option
Echo.
Echo. Title %%_Menu_Option%%x%%_Sub_menu_option%%
Echo. Goto :Top
Echo.
echo. This version %_Ver% of MenuBar function contains much more GUI Capabilities.
echo. As it uses batbox.exe and calls it only once at the end of calculation...
Echo. For the most efficient output. This ver. uses GetInput By Aacini too. For the
Echo. Advanced Output on the console.
Echo.
echo. Created By 'Kvc' aka "Karanveer Chouhan"
echo. Visit www.thebateam.org for more...
echo. #TheBATeam
goto :eof
