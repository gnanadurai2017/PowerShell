$regKey="HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

$proxyServer = ""
$proxyServerToDefine = "IP:PORT"

$proxyException ="<local>"

Write-Host "Retrieve the proxy server ..."

$proxyServer = Get-ItemProperty -path $regKey ProxyServer -ErrorAction SilentlyContinue


Write-Host $proxyServer


if([string]::IsNullOrEmpty($proxyServer))

{

    Write-Host "Proxy is Currently disabled"

    Set-ItemProperty -path $regKey ProxyEnable -value 1

    Set-ItemProperty -path $regKey ProxyServer -value $proxyServerToDefine
    
    Set-ItemProperty -path $regKey ProxyOverride -value $proxyException
    
    Set-ItemProperty -path $regKey Proxy -value $proxyException

    Write-Host "Proxy is now enabled "$proxyServerToDefine

}

else

{

    Write-Host "Proxy is Currently enabled"

    Set-ItemProperty -path $regKey ProxyEnable -value 0

    Remove-ItemProperty -path $regKey -name ProxyServer

    Write-Host "Proxy is now disabled"

}
