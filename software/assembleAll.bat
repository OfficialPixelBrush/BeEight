@echo off

rem Define the folder path containing the .asm files
set folderPath=%~dp0

rem Loop through all files with the .asm extension in the folder
for /f "tokens=*" %%a in ('dir /b /s "%folderPath%\*.asm"') do (
  
  rem Call customasm.exe with the current file path
  call customasm.exe "%%a"
  
  rem (Optional) You can add a pause here to see the output for each file
  rem pause
)

echo Done processing all .asm files.