Write-Host "No Hinting PLZ"

# TTC.
$ttcs = Get-ChildItem .\input\*.ttc
Foreach ($ttc in $ttcs)
{
    Remove-Item .\temp\*.ttc
    Remove-Item .\temp\*.ttf

    $name = $ttc.Name
    Write-Output "Processing: $name"
    Copy-Item $ttc .\temp\$name

    Set-Location .\temp\
    .\UniteTTC.exe $name > $null
    Set-Location ..\

    Remove-Item .\temp\$name

    Get-ChildItem .\temp\*.ttf | ForEach-Object -ThrottleLimit 5 -Parallel {
        $tempName = $_.Name
        cmd /c ".\otfccdump --ignore-hints $_ | .\otfccbuild -o .\temp\$tempName"
    }

    [system.gc]::Collect()

    Set-Location .\temp\
    .\AllUniteTTC.exe > $null
    Set-Location ..\

    Copy-Item .\temp\*.ttc .\output\$name
    Write-Output "Completed: $name"

    Remove-Item .\temp\*.ttc
    Remove-Item .\temp\*.ttf
}

# TTF/OTF.
Get-ChildItem .\input\* -Include ('*.ttf', '*.otf') | ForEach-Object -ThrottleLimit 5 -Parallel {
    $name = $_.Name
    Write-Host "Processing: $name"

    cmd /c ".\otfccdump --ignore-hints $_ | .\otfccbuild -o .\output\$name"
    
    [system.gc]::Collect()

    Write-Host "Completed: $name"
}