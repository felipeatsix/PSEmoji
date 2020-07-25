function Remove-PSEmoji {
    Param (        
        [Parameter(Mandatory = $true)]
        [emojicategories]$EmojiCategory,
        
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            $true -eq $PSEMOJI.emojis.$EmojiCategory.$PSItem
        })]
        [string]$EmojiName
    )
    BEGIN {        
        $unicode = Get-Content $UNICODE_JSON | ConvertFrom-Json
        $setContent = @{
            Path  = $UNICODE_JSON
            Value = $null
            Force = $true
        }
        $output = [pscustomobject]@{
            category      = $EmojiCategory
            name          = $EmojiName
            emoji_removed = $false
        }
    }
    PROCESS {
        try {
            $unicode.$EmojiCategory.psobject.properties.remove($EmojiName)
            $setContent.Value = $unicode | ConvertTo-Json
            Set-Content @setContent
            $output.emoji_removed = $true
        } 
        catch { throw }
    }
    END {
        Write-Output $output
    }
}