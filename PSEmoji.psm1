$root = $PSScriptRoot
New-Variable -Name "UNICODE_JSON" -Value "$root\lib\EmojiUnicode.json"
New-Variable -Name "PSEMOJI_CATEGORIES" -Value "$root\src\enums\categories.ps1"
$files = Get-ChildItem -Path $root -File -Include *.ps1 -Recurse
try {
    $files.FullName | ForEach-Object { . $PSItem }
}
catch {
    throw
}
$PSEMOJI = [psemoji]::new()
Export-ModuleMember -Variable "PSEMOJI"