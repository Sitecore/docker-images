
# detach DB
Get-ChildItem -Path $Env:INSTALL_PATH -Filter "*.mdf" | ForEach-Object {
    $databaseName = $_.BaseName.Replace("_Primary", "")

    Write-Host "### Detaching '$databaseName'..."

    Invoke-Sqlcmd -Query "DECLARE @processid INT 
        SELECT  @processid = MIN(spid)
        FROM    master.dbo.sysprocesses
        WHERE   dbid = DB_ID('$databaseName') 
        WHILE @processid IS NOT NULL 
        BEGIN 
            EXEC ('KILL ' + @processid) 
            SELECT  @processid = MIN(spid)
            FROM    master.dbo.sysprocesses
            WHERE   dbid = DB_ID('$databaseName') 
        END"

    Invoke-Sqlcmd -Query "EXEC MASTER.dbo.sp_detach_db @dbname = N'$databaseName', @keepfulltextindexfile = N'false'"
}