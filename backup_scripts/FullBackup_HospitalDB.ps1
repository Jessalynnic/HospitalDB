# FullBackup_HospitalDB.ps1

Import-Module dbatools

$backupDir = "C:\SQLBackups\HospitalDB"

if (-not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

$dbName = "HospitalDB"
$timestamp = Get-Date -Format "yyyy-MM-dd_HHmm"
$backupFile = "$backupDir\HospitalDB_FULL_$timestamp.bak"

Write-Host "Backing up to: $backupDir"

Backup-DbaDatabase -SqlInstance "localhost" -Database $dbName -FilePath $backupFile -Type Full -CompressBackup -Initialize -IgnoreFileChecks

Write-Host "Full Backup completed: $backupFile"