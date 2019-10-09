[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$UserDomain,
    [Parameter(Mandatory=$true)]
    [string]$UserName,
    [Parameter(Mandatory=$true)]
    [string]$UserPassword
)

function NewLocalUser
{
      PARAM
      (
        [String]$UserName=$(throw 'Parameter -UserName is missing!'),
        [String]$Password=$(throw 'Parameter -Password is missing!')
      )
      Trap
      {
        Write-Host "Error: $($_.Exception.GetType().FullName)" -ForegroundColor Red ;
        Write-Host $_.Exception.Message;
        Write-Host $_.Exception.StackTrack;
        break;
      }

      Write-Host "Creating $($UserName)";

      #$response = Invoke-Expression -Command "NET USER $($UserName) `"/add`" $($Password) `"/passwordchg:no`" `"/expires:never`"";

      $objOu = [ADSI]"WinNT://$env:COMPUTERNAME";
      $objUser = $objOU.Create("User", $UserName);

      $objUser.setpassword($Password);
      $objUser.SetInfo();

      $objUser.description = "$UserName";
      $objUser.SetInfo();

      $objUser.UserFlags.value = $objUser.UserFlags.value -bor 64;
      $objUser.UserFlags.value = $objUser.UserFlags.value -bor 65536;
      $objUser.SetInfo();

      Write-Host "Response from creating local user: $response";
}

try {
    $objComputer = [ADSI]("WinNT://$UserDomain, computer");
    $colUsers = ($objComputer.psbase.children |
    Where-Object {$_.psBase.schemaClassName -eq "User"} |
    Select-Object -expand Name)

    if ($colUsers -contains $UserName) {
        Write-Host "The user account exists.";
    }
    else {
        Write-Host "The user account does not exist ... creating user '$UserName'.";
        NewLocalUser -UserName $UserName -Password $UserPassword
    }
}
catch {
    Write-Error $_
}