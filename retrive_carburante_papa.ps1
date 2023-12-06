#Script per scaricare file dal sito https://www.mimit.gov.it (osservatore prezzi carburante)

$CARTELLA_DESTINAZIONE = "test/"
$FILE_NAME = "$CARTELLA_DESTINAZIONE$(Get-Date -Format 'yyyyMMdd')_prezzo_carburante.csv"
$FILE_TO_DOWNLOAD = "https://www.mimit.gov.it/images/exportCSV/prezzo_alle_8.csv"

Invoke-WebRequest -Uri $FILE_TO_DOWNLOAD -OutFile $FILE_NAME