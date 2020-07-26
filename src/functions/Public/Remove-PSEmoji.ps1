<#
.SYNOPSIS
    Removes an emoji from an emoji category.

.DESCRIPTION
    Removes a value from a nested property from UnicodeJson.json file.

.PARAMETER EmojiCategory
    Provides an emoji category name to remove the emoji from.

.PARAMETER EmojiName
    Provides the emoji name to be removed.

.EXAMPLE
    Remove-PSEmoji -EmojiCategory space -EmojiName saturn
    This command will remove the emoji of name 'saturn' from the emoji category 'space'

.NOTES
    Author: Felipe de Souza Santos
    Data: 07/26/2020
#>
function Remove-PSEmoji {
    Param (        
        [Parameter(Mandatory = $true)]
        [ValidateScript({
            $PSEMOJI.emojis.psobject.properties.name -contains $PSItem
        })]
        [string]$EmojiCategory,
        
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
        return $($PSEMOJI.refresh())
    }
}