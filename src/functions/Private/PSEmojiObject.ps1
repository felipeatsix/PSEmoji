$PSEMOJI_BUILD = Get-Content $UNICODE_JSON | ConvertFrom-Json
foreach ($category in $PSEMOJI_BUILD.psobject.properties.name) {
    $item = $PSEMOJI_BUILD.$category
    foreach ($property in $item.psobject.properties.name) {
        $emoji = [convert]::ToInt32($item.$property, 16)
        $PSEMOJI_BUILD.$category.$property = [char]::ConvertFromUtf32($emoji)
    }
}
class psemoji {
    [string]$Unicode_Json = $UNICODE_JSON    
    [pscustomobject]$Emojis = $PSEMOJI_BUILD    
    [void]refresh(){        
        $this.emojis = Get-Content $this.unicode_json | ConvertFrom-Json
        foreach ($category in $this.emojis.psobject.properties.name) {
            $item = $this.emojis.$category
            if ($null -ne $item) {
                foreach ($property in $item.psobject.properties.name) {
                    $emoji = [convert]::ToInt32($item.$property, 16)
                    $this.emojis.$category.$property = [char]::ConvertFromUtf32($emoji)
                }
            }
        }
    }
    [void]UnicodeCharts_Open() {
        Start-Process "{0}" -f "https://unicode.org/emoji/charts/emoji-list.html"
    }
}