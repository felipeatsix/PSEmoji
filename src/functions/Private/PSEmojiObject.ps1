$PSEMOJI_build = Get-Content $UNICODE_JSON | ConvertFrom-Json
foreach ($category in $PSEMOJI_build.psobject.properties.name) {
    $item = $PSEMOJI_build.$category
    foreach ($property in $item.psobject.properties.name) {
        $emoji = [convert]::ToInt32($item.$property, 16)
        $PSEMOJI_build.$category.$property = [char]::ConvertFromUtf32($emoji)
    }
}
class psemoji {
    [string]$unicode_json = $UNICODE_JSON
    [pscustomobject]$emojis = $PSEMOJI_build
    [void]refresh(){        
        $this.emojis = Get-Content $this.unicode_json | ConvertFrom-Json
        foreach ($category in $this.emojis.psobject.properties.name) {
            $item = $this.emojis.$category
            foreach ($property in $item.psobject.properties.name) {
                $emoji = [convert]::ToInt32($item.$property, 16)
                $this.emojis.$category.$property = [char]::ConvertFromUtf32($emoji)
            }
        }        
    }
}