$root = $PSScriptRoot
New-Variable -Name "UNICODE_JSON" -Value "$root\lib\EmojiUnicode.json"
$files = Get-ChildItem -Path $root -File -Include *.ps1 -Recurse
try {
    $files.FullName | ForEach-Object { . $PSItem }
}
catch {
    throw
}
New-Variable -Name PSEMOJI -Value $([psemoji]::new())
Export-ModuleMember -Variable "PSEMOJI"