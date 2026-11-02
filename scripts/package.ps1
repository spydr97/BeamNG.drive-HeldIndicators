# Zips the mod folder into dist/held_indicators.zip, its contents at the zip's root (as BeamNG expects).
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$dist = Join-Path $root 'dist'
$zip = Join-Path $dist 'held_indicators.zip'

New-Item -ItemType Directory -Force $dist | Out-Null
Remove-Item $zip -ErrorAction SilentlyContinue
Add-Type -AssemblyName System.IO.Compression.FileSystem
[IO.Compression.ZipFile]::CreateFromDirectory((Join-Path $root 'mod'), $zip)
Write-Host "Built $zip"
