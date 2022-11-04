###--------------script configurazione iniziale di un pc Windows----------------###
<#

--------------------------------
todo installazione app :

permettere l'esecuzione di script al sistema (OK)
controllare se pm è gia installato (OK)
installare packege manager (chocolaty) (OK)
per ogni app controllare se gia installata  (OK)
installare applicazioni tramite choco (OK)
capire se possibile installare app al di fuori di choco
installare tutto in silent mode

----------------------------------
todo configurazione sistema:
creare un account amministrativo di management con password sicura
controllare l'edizione di windows e in caso abilitare rdp


#>

###Prima di iniziare###
# 1) Inserisci o togli app da installare aggingendo o togliendoli dalla variabile $Packages+

 ###-----------Inserire app da installare -------------###
 #$Packages = 'googlechrome', 'git', 'notepadplusplus', 'everything' , 'bitwarden' , 'bitwarden-chrome' ,'ditto' ,'revo-uninstaller','eartrumpet', 'gimp', 'idrive','vscode','azure-cli','notion','vscode-ansible','wsl','pdftk','obs-studio','putty','sharex','telegram','whatsapp','vlc','winrar','winscp','vscode-terraform','terraform'
 $Packages = 'bitwarden-chrome', 'patch-my-pc' ,'eartrumpet','idrive','azure-cli','wsl','terraform'
#Assegnazioni variabili di scelta (per proseguire lo script)
$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Descrizione."
$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No","Descrizione."
$cancel = New-Object System.Management.Automation.Host.ChoiceDescription "&Cancel","Descrizione."
$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no, $cancel)

###------lista pacchetti da installare si aspetta una conferma da parte dell'utente prima di proseguire----------###

Write-Host "Questi sono i Pacchetti che hai scelto di installare:"
Write-Host  "$Packages"


$title = "Avvio Script"
$message = "Vuoi procedere?"
$result = $host.ui.PromptForChoice($title, $message, $options, 1)
switch ($result) {
0{

    ## Inserire il codice da eseguire in caso di risposta affermativa
    Write-Host "Avvio Script:"

    $getexpolicy = Get-ExecutionPolicy -Scope CurrentUser
    if($getexpolicy -eq "RemoteSigned"){

        Write-Host "Execution policy : $getexpolicy"
    }
    else{
        Write-Host "set ExecutionPoliy to RemoteSigned"
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    }

    #controllo dell'esistenza del package manager chocolaty
    If(Test-Path -Path "$env:ProgramData\Chocolatey") {
         ###--------installazione app-----------###
        ForEach ($PackageName in $Packages){
            if (Test-Path -Path "C:\Programmi\$PackageName") {
                Write-Host "$Package già installata"
            }
            else {
                Write-Host "Installazione : $Packages"
                choco install $PackageName -y
            }
        }
    }
    Else {

        #you must have internet connection to do this operation
        #installing chocolaty
        Write-Host "Installing Package Manager Chocolaty"
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

       
        ###----------------------------------------------------###
        ###--------installazione app-----------###
        ForEach ($PackageName in $Packages){
            if (Test-Path -Path "C:\Programmi\$PackageName") {
                Write-Host "$Package già installata"
            }
            else {
                Write-Host "Installazione : $Packages"
                choco install $PackageName -y
            }
        }
    }
}
1{
    ## Inserire il codice da eseguire in caso di risposta negativa
    Write-Host "Ok, interruzione script"
}
2{
    ## Inserire il codice da eseguire nel caso l'utilizzatore selezioni "cancel"
    Write-Host "Cancel"
}
}