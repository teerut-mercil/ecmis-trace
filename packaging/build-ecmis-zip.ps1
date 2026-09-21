# แพ็ก skill ecmis + ชุดโปรเจกต์ตั้งต้น ecmis-trace + ตัวติดตั้ง เป็นไฟล์ zip เดียว (Windows)
# ใช้: powershell -ExecutionPolicy Bypass -File packaging\build-ecmis-zip.ps1 [-OutDir dist]
# ไฟล์นี้ต้องบันทึกเป็น UTF-8 with BOM เพื่อให้ Windows PowerShell 5.1 อ่านภาษาไทยได้
param([string]$OutDir)
$ErrorActionPreference = 'Stop'
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}

$Here = Split-Path -Parent $MyInvocation.MyCommand.Path
$Repo = Split-Path -Parent $Here
$Src = Join-Path $Repo 'ecmis-trace'
if (-not $OutDir) { $OutDir = Join-Path $Repo 'dist' }

$Version = Get-Date -Format 'yyyyMMdd'
$Sha = & git -C $Repo rev-parse --short HEAD 2>$null
if ($LASTEXITCODE -eq 0 -and $Sha) { $Version = "$Version-$Sha" }
$Name = "ecmis-skill-$Version"

$Stage = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString())
$Pkg = Join-Path $Stage $Name
try {
    # skill
    New-Item -ItemType Directory -Force -Path (Join-Path $Pkg 'skill') | Out-Null
    Copy-Item -Recurse (Join-Path $Src '.claude\skills\ecmis') (Join-Path $Pkg 'skill\ecmis')

    # ชุดโปรเจกต์ตั้งต้น (ไม่รวมข้อมูลงานใน input/work/output)
    $P = Join-Path $Pkg 'project\ecmis-trace'
    foreach ($d in 'template', 'input\docs', 'input\code', 'work\docs', 'work\extract', 'output\backup') {
        New-Item -ItemType Directory -Force -Path (Join-Path $P $d) | Out-Null
        if ($d -ne 'template') { New-Item -ItemType File -Force -Path (Join-Path $P "$d\.gitkeep") | Out-Null }
    }
    Copy-Item (Join-Path $Src 'CLAUDE.md'), (Join-Path $Src 'README.md') $P
    Copy-Item (Join-Path $Src 'template\*.xlsx') (Join-Path $P 'template')

    # ตัวติดตั้ง
    foreach ($f in 'install.sh', 'install.ps1', 'install.cmd', 'README.txt') {
        Copy-Item (Join-Path $Here "installer\$f") $Pkg
    }
    Set-Content -Path (Join-Path $Pkg 'VERSION') -Value $Version -NoNewline

    Get-ChildItem -Path $Pkg -Recurse -Force |
        Where-Object { $_.Name -in '.DS_Store', '__pycache__' -or $_.Extension -eq '.pyc' } |
        Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

    New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
    $Zip = Join-Path (Resolve-Path $OutDir) "$Name.zip"
    if (Test-Path $Zip) { Remove-Item $Zip }
    Compress-Archive -Path $Pkg -DestinationPath $Zip
    Write-Host "สร้างไฟล์แล้ว: $Zip"
} finally {
    Remove-Item -Recurse -Force $Stage -ErrorAction SilentlyContinue
}
