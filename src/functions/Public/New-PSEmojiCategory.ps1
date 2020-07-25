function New-PSEmojiCategory {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )
    BEGIN {        
        $unicode = Get-Content $UNICODE_JSON | ConvertFrom-Json        
        $setContent = @{
            Path  = $null
            Value = $null
            Force = $true
        }        
        $params = @{
            MemberType  = 'NoteProperty'
            InputObject = $unicode
            Name        = $Name
            Value       = $null
            Force       = $true
        }
        $output = [pscustomobject]@{
            category       = $Name
            category_added = $false
        }  
    }
    PROCESS {
        try {
            Add-Member @params
            $setContent.Path = $UNICODE_JSON   
            $setContent.Value = $unicode | ConvertTo-Json
        }
        catch { throw }
        try {
            Set-Content @setContent
            $output.category_added = $true
        }        
        catch { throw }
        $enum = [emojicategories].GetEnumNames()
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