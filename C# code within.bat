@echo off
setlocal
:ccodeinbatdemo
set runed=false
:: StartIDpsinbat
call :getLineNumber startLine StartIDpsinbat 0
goto ccodeend
:ccodestart
set /a startline=startline+4&set /a endline=endline-3
title c code in bat demo & powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[System.Management.Automation.ScriptBlock]::create((Get-Content \"%~f0\" -TotalCount $env:endline|Where-Object{$_.readcount -gt $env:startline }) -join \"`n\");&$s" %*&goto ccodeend

#disable exit button within batch
#Calling user32.dll methods for Windows and Menus
$code = @'
using System;
using System.Runtime.InteropServices;

namespace CloseButtonToggle {

 internal static class WinAPI {
   [DllImport("kernel32.dll")]
   internal static extern IntPtr GetConsoleWindow();

   [DllImport("user32.dll")]
   [return: MarshalAs(UnmanagedType.Bool)]
   internal static extern bool DeleteMenu(IntPtr hMenu,
                          uint uPosition, uint uFlags);

   [DllImport("user32.dll")]
   [return: MarshalAs(UnmanagedType.Bool)]
   internal static extern bool DrawMenuBar(IntPtr hWnd);

   [DllImport("user32.dll")]
   internal static extern IntPtr GetSystemMenu(IntPtr hWnd,
              [MarshalAs(UnmanagedType.Bool)]bool bRevert);

   const uint SC_CLOSE     = 0xf060;
   const uint MF_BYCOMMAND = 0;

   internal static void ChangeCurrentState(bool state) {
     IntPtr hMenu = GetSystemMenu(GetConsoleWindow(), state);
     DeleteMenu(hMenu, SC_CLOSE, MF_BYCOMMAND);
     DrawMenuBar(GetConsoleWindow());
   }
 }

 public static class Status {
   public static void Disable() {
     WinAPI.ChangeCurrentState(false); //if you want enable it, chenge 'true'
   }
 }
}
'@

Add-Type $code
[CloseButtonToggle.Status]::Disable()

:ccodeend
:: EndIDpsinbat
call :getLineNumber endLine EndIDpsinbat 0
if {%runed%}=={false} (set runed=true&goto ccodestart) else (goto :end)

:GetLineNumber <resultVar> <uniqueID> [LineOffset]

SETLOCAL
for /F "usebackq tokens=1 delims=:" %%L IN (`findstr /N "%~2" "%~f0"`) DO set /a lineNr=%~3 + %%L
(
ENDLOCAL
 set "%~1=%LineNr%"
 goto :eof
)

:end
echo hello world.
pause
exit