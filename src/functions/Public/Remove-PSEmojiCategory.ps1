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