param([string] $username = $env:USERNAME)

Write-Host ('----')
Write-Host ('$PSCommandPath', $PSCommandPath)
Write-Host ('$Profile', $profile)

function go {cd "C:\dev"}
function work {cd "T:\dev\work"}

$profileDirectory = $profile | Split-Path
function goconfig {cd $profileDirectory}
function ecfg {nvim $profile}

function editOldConfig {nvim "C:\Users\$username\Documents\WindowsPowerShell\profile.ps1"}
function resetOldConfig {. "C:\Users\$username\Documents\WindowsPowerShell\profile.ps1"}

# to apply changes to the current powershell session use . or resetCfg
# eg: `. ./profile.ps1`
