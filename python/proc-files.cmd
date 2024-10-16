@echo off
cable-no-x-static -bom -in sofs\output\sofs12-case2-n01.cbl -out sofs\output\sofs12-case2-n01.bom
SETLOCAL EnableDelayedExpansion
FOR %%i IN ("sofs\output\*.cbl") DO (
	ECHO %%i
	echo path: %%~pi
	echo name: %%~ni
	echo ext: %%~xi
	set "in_fn=%%i"
	set "crs_fn=sofs\output\%%~ni.crs"
	set "mat_fn=sofs\output\%%~ni.mat"
	echo in_file : !in_fn! crs_file : !crs_fn! mat_file : !mat_fn!
	rem cable-no-x-static -in !in_fn! -out !crs_fn! -sample 0.1 -snap_dt 1 -connectors -first -last -quiet
	rem res2mat -in !crs_fn! -out !mat_fn!
)