@echo off
SETLOCAL EnableDelayedExpansion
FOR %%i IN ("output\*.cbl") DO (
	ECHO %%i
	rem echo path: %%~pi
	rem echo name: %%~ni
	rem echo ext: %%~xi
	set "in_fn=%%i"
	set "crs_fn=output\%%~ni.crs"
	set "mat_fn=output\%%~ni.mat"
	echo in_file : !in_fn! crs_file : !crs_fn! mat_file : !mat_fn!
	cable-no-x-static -in !in_fn! -out !crs_fn! -sample 0.1 -snap_dt 1 -connectors -first -last -quiet
	res2mat -in !crs_fn! -out !mat_fn!
)