function Import-PSEmojiUnicodeJson {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateScript( {
                $(Test-Path $PSItem) -and
                $PSItem -like '*EmojiUnicode.json'                
            })]
        $Path
    )
    BEGIN {
        $output = [pscustomobject]@{
            source        = $Path
            destination   = $UNICODE_JSON
            imported_data = $null
        }
    }
    PROCESS {
        try {
            Get-Content $Path | Set-Content $UNICODE_JSON -Force
            $output.imported_data = $true
        }
        catch { throw }
    }
    END {
        Write-Output $output
        return $($PSEMOJI.refresh())
    }
}