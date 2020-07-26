<#
.SYNOPSIS
    Add a new emoji to a given emoji category.

.DESCRIPTION
    Updates the UnicodeJson.json for adding new emojis. 

.PARAMETER EmojiCategory
    Provides a new emoji category name.

.PARAMETER EmojiName
    Provides a new emoji name.

.PARAMETER EmojiUnicode
    Provides the emoji unicode.

.EXAMPLE
    Add-PSEmoji -EmojiCategory space -EmojiName saturn -EmojiUnicode U+1FA90.
    This command will add a new emoji called saturn with unicode value of U+1FA90 to the emoji category 'space'.
    Notes: 
        1. Space category isn't created by default, use New-PSEmojiCategory to create it before hand.
        2. The -EmojiUnicode parameter does not require the initial chars "U+" or "u+", they'll be ignored if provided in the input though.

.NOTES
    Author: Felipe de Souza Santos.
    Date: 07/26/2020
#>
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
        $regex = [regex]::new('[u,U]+')
        if ($EmojiUnicode -match $regex){
            $EmojiUnicode = $EmojiUnicode.TrimStart($regex.ToString())
        }
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