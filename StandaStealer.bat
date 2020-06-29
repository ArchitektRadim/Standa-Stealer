@echo off

:LINK

setlocal EnableDelayedExpansion

set /p "LINK=Link na probihajici Standuv stream: "

lib\youtube-dl.exe --list-formats %LINK%

ECHO Vyber format, kodek a rozliseni...

set /p CISLO=Cislo formatu: 

lib\youtube-dl.exe -f %CISLO% -g %LINK% > stream.txt

set /p STREAM=<stream.txt

del stream.txt

ECHO Jakou koncovku videa sis zvolil?

set /p EXT=Koncovka: 

for /f "tokens=*" %%i in ('cscript //nologo lib\browse.vbs') do set PATH=%%i

lib\youtube-dl.exe --get-filename -o "%%(title)s" "!LINK!" > videotitle.txt

set /p VIDEOTITLE=<videotitle.txt

del videotitle.txt

lib\ffmpeg.exe -i %STREAM% -c copy "%PATH%\%VIDEOTITLE%.%EXT%"

ECHO "%VIDEOTITLE%" uspesne stazeno do slozky %PATH%!

@pause