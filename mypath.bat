@echo off
@if exist d:\temp\mypath.pl goto dmypath
@if exist c:\temp\mypath.pl goto cmypath
goto mypathbatende
REM perl.exe must be found in PATH already, otherwise add the folder to PATH
REM If you have more than 4 folder actions be aware to call the perl.exe command yourself on command line
REM   DOS-Box/Windows-command line can't handle more parameters than %9
:cmypath
perl.exe c:\temp\mypath.pl %1 %2 %3 %4 %5 %6 %7 %8 %9
call mypathnew
goto mypathbatende
:dmypath
perl.exe d:\temp\mypath.pl %1 %2 %3 %4 %5 %6 %7 %8 %9
call mypathnew
goto mypathbatende
:mypathbatende
