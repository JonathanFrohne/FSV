@echo off
if "%~1"=="" (
    echo Usage: %0 ^<your_file.dfy^>
    exit /b 1
)
if not exist "%~1" (
    echo Error: File '%~1' not found.
    exit /b 1
)

:: Create output directory or clear it before compiling
mkdir dfy_out 2>nul
del /q dfy_out\* 2>nul

:: Compile the Dafny file and specify the output directory for the executable - automatically runs it
dotnet "C:\Users\Jonathan\.vscode\extensions\dafny-lang.ide-vscode-3.5.2\out\resources\4.11.0\github\dafny\Dafny.dll" "%~1" /compile:3 /out:dfy_out\%~n1.exe
