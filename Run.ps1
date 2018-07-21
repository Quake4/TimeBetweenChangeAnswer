<#
Copyright (C) 2018  Oleg Samsonov aka Quake4
https://github.com/Quake4
License GPL-3.0
#>

param(
    [Parameter(Mandatory = $true)][string] $Url,
    [Parameter(Mandatory = $true)][int] $Timeout
)

. .\Get-Http.ps1

[string] $global:prevResult = [string]::Empty
do {
	Get-Http $Url {
		param([string] $result)

		if ([string]::IsNullOrWhiteSpace($result)) {
			Write-Host "Empty result $([datetime]::Now)"
		}
		elseif ($global:prevResult -eq [string]::Empty) {
			$global:prevResult = $result
			Write-Host "Save result $([datetime]::Now)"
		}
		elseif (![string]::Equals($global:prevResult, $result)) {
			Write-Host "Changed $([datetime]::Now)"
			$global:prevResult = $result
		}
	}

	Write-Host "Sleep $Timeout sec."
	Start-Sleep -Seconds $Timeout
} while ($true);