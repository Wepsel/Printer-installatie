# Stel het pad voor het logbestand in
$logPath = "C:\ProgramData\WiFiCheckLog.txt"

# Functie om berichten naar het logbestand te schrijven
function Write-Log {
    param (
        [string]$Message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logPath -Value "[$timestamp] $Message"
}

# Start logging
Write-Log "Script started. Checking Wi-Fi connection..."

# Controleer de actieve SSID van de Wi-Fi-verbinding
$wifiInfo = netsh wlan show interfaces | Select-String -Pattern "SSID\s+: eduroam"

if ($wifiInfo) {
    # De machine is verbonden met eduroam
    Write-Log "Connected to eduroam"
    Write-Output $true  # Output naar STDOUT (voor Intune)
    exit 0              # Exit-code voor succesvolle scriptuitvoering
} else {
    # Niet verbonden met eduroam
    Write-Log "Not connected to eduroam"
    Write-Output $false  # Output naar STDOUT (voor Intune)
    exit 0               # Exit-code voor succesvolle scriptuitvoering
}
