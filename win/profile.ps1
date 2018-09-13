param([string] $username)
Write-Host ('Profile for', $username, 'in "Documents/WindowsPowerShell"') -Separator ' '
function go {cd C:\dev}
function goconfig {cd "C:\Users\$username\Documents\WindowsPowerShell"}
function ecfg {nvim "C:\Users\$username\Documents\WindowsPowerShell\profile.ps1"}

# to apply changes to the current powershell session use .
# eg: `. ./profile.ps1`
