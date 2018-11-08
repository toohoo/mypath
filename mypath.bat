@echo off
@if exist d:\temp\mypath.pl goto dmypath
@if exist z:\temp\zmypath.pl goto zmypath
goto mypathbatende
:zmypath
call perl z:\temp\zmypath.pl %1 %2 %3 %4 %5 %6 %7 %8 %9
goto mypathbatende
:dmypath
call perl d:\temp\mypath.pl %1 %2 %3 %4 %5 %6 %7 %8 %9
goto mypathbatende
:mypathbatende
