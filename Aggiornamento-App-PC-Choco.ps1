#script per aggiornare applicazioni installate con choco
#todo:
<#
creare uno scadule task che permetta l'esecuzuine automatica dello script ogni (tot tempo, o trigger) (OK)
aggiorna tutte le app (OK)
#>

###-----Attenzione-----------###
#Cambiare il parametro -Argument con il path dello script


#$Packages = 'googlechrome', 'git', 'notepadplusplus', 'everything' , 'bitwarden' , 'bitwarden-chrome' ,'ditto' ,'revo-uninstaller','eartrumpet', 'gimp', 'idrive','vscode','azure-cli','notion','vscode-ansible','wsl','pdftk','obs-studio','putty','sharex','telegram','whatsapp','vlc','winrar','winscp','vscode-terraform','terraform'
$Packages = 'bitwarden-chrome', 'patch-my-pc' ,'eartrumpet','idrive','azure-cli','wsl','terraform'

if (Get-ScheduledTask -TaskName "daily-check-app-update"){
    choco upgrade $Packages -y
}
else{
    $action = New-ScheduledTaskAction -Execute  'powershell.exe' -Argument "<PATHS_CRIPT>"
    $trigger = New-ScheduledTaskTrigger -Daily -At 11:00
    Register-ScheduledTask -Action $action -Trigger $trigger -TaskPath "MyTask" -TaskName "daily-check-app-update" -Description "Controllo giornalmente se sono ci sono aggiornamenti sulle app installate nel pc e in caso le aggiorna"
}
