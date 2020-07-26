<#
.SYNOPSIS
    Removes an emoji category.

.DESCRIPTION
    Removes a master property from UnicodeJson.json file.

.PARAMETER Name
    Provides an emoji category name to be removed.

.EXAMPLE
    Remove-PSEmojiCategory -Name space
    This command will remove an emoji category of name 'space'.

.NOTES
    Author: Felipe de Souza Santos
    Date: 07/26/2020
#>
function Remove-PSEmojiCategory {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            $PSEMOJI.emojis.psobject.properties.name -contains $PSItem
        })]
        [string]$Name
    )
    BEGIN { 
        $unicode = Get-Content $UNICODE_JSON | ConvertFrom-Json
        $setContent = @{
            Path  = $null
            Value = $null
            Force = $true
        }
        $output = [pscustomobject]@{
            category         = $Name
            category_removed = $false
        }
    }
    PROCESS {
        try {
            $unicode.psobject.properties.remove($Name)
            $setContent.Path = $UNICODE_JSON
            $setContent.Value = $unicode | ConvertTo-Json
            Set-Content @setContent
            $output.category_removed = $true
        }
        catch { throw }
    }
    END {
        Write-Output $output
        return $($PSEMOJI.refresh())
    }
}