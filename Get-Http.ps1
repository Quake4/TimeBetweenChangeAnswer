<#
Copyright (C) 2018  Oleg Samsonov aka Quake4
https://github.com/Quake4
License GPL-3.0
original source https://github.com/Quake4/MindMiner/Code/Get-Speed.ps1
#>

function Get-Http ([Parameter(Mandatory)][string] $Url, [Parameter(Mandatory)][scriptblock] $Script) {
	try {
		try {
			$Request = Invoke-WebRequest $Url -TimeoutSec 15
		}
		catch {
			if ($Request -is [IDisposable]) { $Request.Dispose(); $Request = $null; }
			$Request = Invoke-WebRequest $Url -UseBasicParsing -TimeoutSec 15
		}
		if ($Request -and $Request.StatusCode -eq 200 -and ![string]::IsNullOrWhiteSpace($Request.Content)) {
			$Script.Invoke($Request.Content)
		}
	}
	catch {
		Write-Host "Get-Speed error: $_" -ForegroundColor Red
	}
	finally {
		if ($Request -is [IDisposable]) { $Request.Dispose(); $Request = $null; }
	}
}