@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------    
	python -m pipreqs.pipreqs --force --no-pin
    python -m pip install -r requirements.txt
    python -m pip install -r requirements.txt --upgrade
<<<<<<< HEAD
    python -m PyInstaller main.py --name="valorant-rpc" --icon=favicon.ico --hidden-import "pystray._win32" --onefile --version-file "version.py"
=======
    python -m PyInstaller main.py --name="valorant-rpc" --icon=favicon.ico --hidden-import "pystray._win32" --version-file "version.py" --onefile
>>>>>>> c3677c5 (Update)
    pause
