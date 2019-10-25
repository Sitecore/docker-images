[CmdletBinding()]
param(
	[Parameter(Mandatory = $true)]
    [string]$SqlHostname,
	[Parameter(Mandatory = $true)]
    [string]$SqlDatabasePrefix,
	[Parameter(Mandatory = $true)]
    [string]$CreateRoles,
	[Parameter(Mandatory = $true)]
    [string]$AddRolesToUserUserNames,
	[Parameter(Mandatory = $true)]
    [string]$AddRolesToUserRoleNames,
	[Parameter(Mandatory = $true)]
    [string]$AddRoleToRoleMemberRoleNames,
	[Parameter(Mandatory = $true)]
    [string]$AddRoleToRoleTargetRoleNames
)

Function OpenConnection {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ConnString
    )
	Write-Host "Open connection"
    try {
        $global:SqlConnection = New-Object System.Data.SqlClient.SqlConnection
        $global:SqlConnection.ConnectionString = $ConnString.Replace('\\', '\')
        $global:SqlConnection.Open()
    }
    catch {
        Write-Host "An error happened in OpenConnection, transaction will be rollbacked..." -ForegroundColor Red
        $global:SqlTransaction.Rollback()
        foreach ( $errorRecord in $Error ) {
            Write-Host -Object $errorRecord -ForegroundColor Red
            Write-Host -Object $errorRecord.InvocationInfo.PositionMessage -ForegroundColor Red
        }
    }
	Write-Host "Connection opened"
}

Function CloseConnection {
	Write-Host "Close connection"
    $global:SqlConnection.Close();
	Write-Host "Connection closed"
}

Function CreateRole {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$RoleName,
        [string]$ApplicationName = "sitecore"
    )

    Write-Host "Create Role $RoleName" -ForegroundColor Green
    try {
	    $global:SqlTransaction = $global:SqlConnection.BeginTransaction()
        $SqlCommand = $global:SqlConnection.CreateCommand()
        $SqlCommand.Transaction = $global:SqlTransaction
        $SqlCommand.CommandText = "[dbo].[aspnet_Roles_CreateRole]"
        $SqlCommand.CommandType = [System.Data.CommandType]::StoredProcedure
        $SqlCommand.Parameters.AddWithValue("@ApplicationName", $ApplicationName) | Out-Null
        $SqlCommand.Parameters.AddWithValue("@RoleName", $RoleName) | Out-Null
        $SqlCommand.ExecuteNonQuery()
		$global:SqlTransaction.Commit();
    }
    catch {
        Write-Host "An error happened, transaction will be rollbacked..." -ForegroundColor Red
        $global:SqlTransaction.Rollback()
        foreach ( $errorRecord in $Error ) {
            Write-Host -Object $errorRecord -ForegroundColor Red
            Write-Host -Object $errorRecord.InvocationInfo.PositionMessage -ForegroundColor Red
        }
    }
}

Function AddRolesToUser {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$UserName,
        [Parameter(Mandatory = $true)]
        [string]$RoleNames,
        [string]$ApplicationName = "sitecore"
    )

    Write-Host "Add user $UserName to roles $RoleNames" -ForegroundColor Green
    try {
		$global:SqlTransaction = $global:SqlConnection.BeginTransaction()
        $SqlCommand = $global:SqlConnection.CreateCommand()
        $SqlCommand.Transaction = $global:SqlTransaction
        $SqlCommand.CommandText = "[dbo].[aspnet_UsersInRoles_AddUsersToRoles]"
        $SqlCommand.CommandType = [System.Data.CommandType]::StoredProcedure
        $SqlCommand.Parameters.AddWithValue("@ApplicationName", $ApplicationName) | Out-Null
        $SqlCommand.Parameters.AddWithValue("@UserNames", $UserName) | Out-Null
        $SqlCommand.Parameters.AddWithValue("@RoleNames", $RoleNames) | Out-Null
        $SqlCommand.Parameters.AddWithValue("@CurrentTimeUtc", (Get-Date)) | Out-Null
        $SqlCommand.ExecuteNonQuery();
		$global:SqlTransaction.Commit();
    }
    catch {
        Write-Host "An error happened, transaction will be rollbacked..." -ForegroundColor Red
        $global:SqlTransaction.Rollback()
        foreach ( $errorRecord in $Error ) {
            Write-Host -Object $errorRecord -ForegroundColor Red
            Write-Host -Object $errorRecord.InvocationInfo.PositionMessage -ForegroundColor Red
        }
    }
}

Function AddRoleToRole {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$MemberRoleName,
        [Parameter(Mandatory = $true)]
        [string]$TargetRoleName,
        [string]$ApplicationName = ""
    )

    Write-Host "Add member role $MemberRoleName to target role $TargetRoleName" -ForegroundColor Green
    try {
		$global:SqlTransaction = $global:SqlConnection.BeginTransaction()
        $SqlCommand = $global:SqlConnection.CreateCommand()
        $SqlCommand.Transaction = $global:SqlTransaction
        $SqlCommand.CommandText = "INSERT INTO RolesInRoles (MemberRoleName, TargetRoleName, ApplicationName, Created) VALUES (@MemberRoleName, @TargetRoleName, @ApplicationName, @CurrentTimeUtc)"
        $SqlCommand.Parameters.AddWithValue("@MemberRoleName", $MemberRoleName) | Out-Null
        $SqlCommand.Parameters.AddWithValue("@TargetRoleName", $TargetRoleName) | Out-Null
        $SqlCommand.Parameters.AddWithValue("@ApplicationName", $ApplicationName) | Out-Null
        $SqlCommand.Parameters.AddWithValue("@CurrentTimeUtc", (Get-Date)) | Out-Null
        $SqlCommand.ExecuteNonQuery()
		$global:SqlTransaction.Commit();
    }
    catch {
        Write-Host "An error happened, transaction will be rollbacked..." -ForegroundColor Red
        $global:SqlTransaction.Rollback()
        foreach ( $errorRecord in $Error ) {
            Write-Host -Object $errorRecord -ForegroundColor Red
            Write-Host -Object $errorRecord.InvocationInfo.PositionMessage -ForegroundColor Red
        }
    }
}

$ConnString="Server=$SqlHostname;Database=${SqlDatabasePrefix}Core;Integrated Security=True;"
$CreateRolesArray=$CreateRoles.split(",")
$AddRolesToUserUserNamesArray=$AddRolesToUserUserNames.split(",")
$AddRolesToUserRoleNamesArray=$AddRolesToUserRoleNames.split(",")
$AddRoleToRoleMemberRoleNamesArray=$AddRoleToRoleMemberRoleNames.split(",")
$AddRoleToRoleTargetRoleNamesArray=$AddRoleToRoleTargetRoleNames.split(",")

try {
	OpenConnection -ConnString $ConnString

	if ($CreateRolesArray -And $CreateRolesArray.Count -gt 0){
		$CreateRolesArray | ForEach-Object {
			CreateRole -RoleName "$_"
		}
	}

	if ($AddRolesToUserUserNamesArray -And $AddRolesToUserRoleNamesArray -And $AddRolesToUserUserNamesArray.Count -gt 0 -And $AddRolesToUserUserNamesArray.Count -eq $AddRolesToUserRoleNamesArray.Count){
		$i = 0
		$AddRolesToUserUserNamesArray | ForEach-Object {
			AddRolesToUser -UserName "$_" -RoleNames $AddRolesToUserRoleNamesArray[$i]
			$i++
		}
	}

	if ($AddRoleToRoleMemberRoleNamesArray -And $AddRoleToRoleTargetRoleNamesArray -And $AddRoleToRoleMemberRoleNamesArray.Count -gt 0 -And $AddRoleToRoleMemberRoleNamesArray.Count -eq $AddRoleToRoleTargetRoleNamesArray.Count){
		$i = 0
		$AddRoleToRoleMemberRoleNamesArray | ForEach-Object {
			AddRoleToRole -MemberRoleName "$_" -TargetRoleName $AddRoleToRoleTargetRoleNamesArray[$i]
			$i++
		}
	}
}
catch {
	foreach ( $errorRecord in $Error ) {
        Write-Host -Object $errorRecord -ForegroundColor Red
        Write-Host -Object $errorRecord.InvocationInfo.PositionMessage -ForegroundColor Red
	}
}
finally{
	CloseConnection 
}