function Add-PSEmoji {
    Param (        
        [Parameter(Mandatory = $true)]    
        [ValidateScript({
            $PSEMOJI.emojis.psobject.properties.name -contains $PSItem
        })]
        $EmojiCategory,
        
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$EmojiName,
        
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$EmojiUnicode
    )
    BEGIN {             
        $unicode = Get-Content $UNICODE_JSON | ConvertFrom-Json
        $setContent = @{
            Path  = $UNICODE_JSON
            Value = $null
            Force = $true
        }
        $params = @{
            MemberType  = 'NoteProperty'
            InputObject = $unicode.$EmojiCategory
            Name        = $EmojiName
            Value       = $EmojiUnicode
            Force       = $true
        }
        $output = [pscustomobject]@{
            category    = $EmojiCategory
            name        = $EmojiName            
            emoji_added = $false
        }
    }
    PROCESS {
        try {            
            Add-Member @params 
        }
        catch { throw }
        try {
            $setContent.Value = $unicode | ConvertTo-Json
            Set-Content @setContent
            $output.emoji_added = $true
        }
        catch { throw }        
    }
    END {
        Write-Output $output
        return $($PSEMOJI.refresh())
    }
}