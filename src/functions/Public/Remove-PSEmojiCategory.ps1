function Remove-PSEmojiCategory {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [emojicategories]$Name
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
        $enum = [emojicategories].GetEnumNames() | Where-Object { $_ -ne $Name }
        $enum = $enum -join ';'
        $setContent.Path = $PSEMOJI_CATEGORIES
        $setContent.Value = $enum
        try {
            Set-Content @setContent
        }
        catch { throw }
    }
    END {
        Write-Output $output
    }
}