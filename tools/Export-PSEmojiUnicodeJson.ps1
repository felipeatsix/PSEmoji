function Export-PSEmojiUnicodeJson {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {
                $(Test-Path $PSItem)
            })]
        $OutFilePath
    )
    BEGIN {
        $output = [pscustomobject]@{
            path          = $OutFilePath
            exported_data = $null
        }
    }
    PROCESS {
        try {
            Copy-Item $UNICODE_JSON -Destination $OutFilePath -Force
            $output.exported_data = $true
        }
        catch { throw }
    }
    END {
        Write-Output $output
    }
}