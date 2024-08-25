@echo off

setlocal EnableDelayedExpansion

set games[0].name=The Sims 2
set games[1].name=The Sims 2 Apartment Life
set games[2].name=The Sims 2 Bon Voyage
set games[3].name=The Sims 2 Celebration Stuff
set games[4].name=The Sims 2 Family Fun Stuff
set games[5].name=The Sims 2 FreeTime
set games[6].name=The Sims 2 Fun with Pets Collection
set games[7].name=The Sims 2 Glamour Life Stuff
set games[8].name=The Sims 2 H M Fashion Stuff
set games[9].name=The Sims 2 IKEA Home Stuff
set "games[10].name=The Sims 2 Kitchen & Bath Interior Design Stuff"
set games[11].name=The Sims 2 Mansion and Garden Stuff
set games[12].name=The Sims 2 Nightlife
set games[13].name=The Sims 2 Open For Business
set games[14].name=The Sims 2 Pets
set games[15].name=The Sims 2 Seasons
set games[16].name=The Sims 2 Teen Style Stuff
set games[17].name=The Sims 2 University

set count=17

for /L %%i in (0, 1, %count%) do (
    echo KEY: HKLM\SOFTWARE\WOW6432Node\EA Games\!games[%%i].name!

    reg add "HKLM\SOFTWARE\WOW6432Node\EA Games\!games[%%i].name!" /v Language /t REG_SZ /d "Brazilian Portuguese" /f
    reg add "HKLM\SOFTWARE\WOW6432Node\EA Games\!games[%%i].name!" /v LanguageName /t REG_SZ /d "Brazilian Portuguese" /f
    reg add "HKLM\SOFTWARE\WOW6432Node\EA Games\!games[%%i].name!\1.0" /v Language /t REG_DWORD /d 10 /f
)

echo The Sims 2 traduzido com sucesso.

endlocal

REM reg add "HKLM\SOFTWARE\WOW6432Node\EA Games\The Sims 2" /v Language /t REG_SZ /d "Brazilian Portuguese" /f
REM reg add "HKLM\SOFTWARE\WOW6432Node\EA Games\The Sims 2\1.0" /v LanguageName /t REG_SZ /d "Brazilian Portuguese" /f
REM reg add "HKLM\SOFTWARE\WOW6432Node\EA Games\The Sims 2\1.0" /v Language /t REG_DWORD /d 17 /f

pause

