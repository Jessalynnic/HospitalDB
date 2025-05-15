Import-Module dbatools

$dbName = "HospitalDB"
$backupDir = "C:\SQLBackups\HospitalDB"
$timestamp = Get-Date -Format "yyyy-MM-dd_HHmm"
$backupFile = "$backupDir\HospitalDB_DIFF_$timestamp.bak"

Write-Host "Backing up to: $backupDir"

Backup-DbaDatabase -SqlInstance "localhost" -Database $dbName -FilePath $backupFile -Type Differential -CompressBackup -Initialize -IgnoreFileChecks

Write-Host "Differential Backup completed: $backupFile"