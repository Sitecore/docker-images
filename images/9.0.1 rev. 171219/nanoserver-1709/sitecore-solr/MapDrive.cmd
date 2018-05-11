@ECHO OFF
SET DRIVE_LETTER=%1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices" /v %DRIVE_LETTER% /d "\??\C:\data" /reg:64