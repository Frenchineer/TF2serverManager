#this menu was made by Frenchineer (@ArmandLemaitre on twitter dot com) feel free to use it.

$steamCMD = "C:\Server\steamcmd" #place your steam CMD exe folder here

function Show-Menu {
    Write-Host "================ SRVmanager ================" -BackgroundColor DarkGray -ForegroundColor Black
    Write-Host ""
    Write-Host "System Config"
    Write-Host ""
    Write-Host "1: Press '1' for task manager."                 -ForegroundColor Cyan
    Write-Host "2: Press '2' for router config."                -ForegroundColor Cyan
    Write-Host "3: Press '3' to kill and uninstall edge"        -ForegroundColor Cyan
    Write-Host ""
    Write-Host "TF2 Config"
    Write-Host ""
    Write-Host "4: Press '4' to kill tf2"                       -ForegroundColor Yellow
    Write-Host "5: Press '5' to launch tf2"                     -ForegroundColor Yellow
    Write-Host "6: Press '6' to update tf2"                     -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Workshop Config"
    Write-Host ""
    Write-Host "6: Press '7' enable downloaded maps"            -BackgroundColor DarkBlue
    Write-Host "7: Press '8' download workshop map"             -BackgroundColor DarkBlue
    Write-Host ""
    Write-Host "q: enter q to quit"                             -ForegroundColor Red
    Write-Host ""
}

function Input-Menu {

    $selection = Read-Host "Please make a selection"

    if ($selection -eq "q") {break}
    if ($selection -eq "1")
    {
        C:\Windows\System32\Taskmgr.exe
        Clear-Host
        Show-Menu
        Write-Host "Task manager opened"
    }
    if ($selection -eq "5")
    {
        Start-Process -FilePath "C:\Server\TF2\srcds.exe" -ArgumentList "-console -game tf +sv_pure 1 +map ctf_2fort +maxplayers 24"
        Clear-Host
        Show-Menu
        Write-Host "TF2 launched, giddy up bois!"
    }
    if ($selection -eq "2")
    {
        Start-Process "http://192.168.1.254" #put your gateway here, type ipconfig /all in CMD or powershell to find it
        Clear-Host
        Show-Menu
        Write-Host "Gateway page opened"
    }
    if ($selection -eq "4")
    {
        Stop-Process -Name "srcds"
        Clear-Host
        Show-Menu
        Write-Host "TF2 killed, Sometimes you just need a little less gaming."
    }
    if ($selection -eq "3")
    {
        Stop-Process -Name "msedge"
        rm "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
        Clear-Host
        Show-Menu
        Write-Host "Edge killed. Get out of here you snake!"

    }
    if ($selection -eq "7")
    {
        Get-ChildItem -Path "C:\Server\steamcmd\steamapps\workshop\content\440\*.bsp" -Recurse -Force | Copy-Item -Destination "C:\Server\TF2\tf\maps"
        Get-ChildItem -Path "C:\Server\steamcmd\steamapps\workshop\content\440\*.bsp" -Recurse -Force | Copy-Item -Destination "C:\xampp\htdocs\tf\maps"
        Clear-Host
        Show-Menu
        Write-Host "Workshop map enabled"
    }
    if ($selection -eq "8")
    {
        $ID = Read-Host "Please enter a workshop ID"
        cd $steamCMD
        Clear-Host
        Show-Menu
        Write-Host "SteamCMD is downloading your item..."
        Start-Process steamcmd.exe -ArgumentList "+login anonymous +workshop_download_item 440 $ID" -Wait
        cd $Home
        Clear-Host
        Show-Menu
        $map = Get-ChildItem -Path "$steamCMD\steamapps\workshop\content\440\$ID\*.bsp" -Name
        Write-Host "Workshop map downloaded here:" "$steamCMD\steamapps\workshop\content\440\$ID\$map"
    }
    if ($selection -eq "6")
    {
        cd $steamCMD
        Clear-Host
        Show-Menu
        Write-Host "SteamCMD is Updating TF2..."
        Start-Process steamcmd.exe -ArgumentList "+login anonymous +app_update 440" -Wait
        cd $Home
        Clear-Host
        Show-Menu
        Write-Host "TF2 is up to date!"
    }

}
Clear-Host
Show-Menu
while($true) 
{
    Input-Menu
}