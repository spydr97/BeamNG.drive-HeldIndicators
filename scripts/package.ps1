# Zips the mod folder into dist/stalk_bindings.zip, its contents at the zip's root (as BeamNG expects).
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$dist = Join-Path $root 'dist'
$zip = Join-Path $dist 'stalk_bindings.zip'

New-Item -ItemType Directory -Force $dist | Out-Null
Remove-Item $zip -ErrorAction SilentlyContinue
Add-Type -AssemblyName System.IO.Compression.FileSystem
[IO.Compression.ZipFile]::CreateFromDirectory((Join-Path $root 'mod'), $zip)
Write-Host "Built $zip"
