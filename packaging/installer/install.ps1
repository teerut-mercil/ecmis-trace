# ติดตั้ง skill /ecmis แบบ global (Windows) ไปที่ %USERPROFILE%\.claude\skills\ecmis
# ถ้ามีของเดิมอยู่ จะย้ายไปสำรองที่ %USERPROFILE%\.claude\skill-backups\ ก่อนติดตั้งทับ
# ไฟล์นี้ต้องบันทึกเป็น UTF-8 with BOM เพื่อให้ Windows PowerShell 5.1 อ่านภาษาไทยได้
$ErrorActionPreference = 'Stop'
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}

$Here = Split-Path -Parent $MyInvocation.MyCommand.Path
$Src = Join-Path $Here 'skill\ecmis'
$ClaudeHome = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }
$Dest = Join-Path $ClaudeHome 'skills\ecmis'
$BackupRoot = Join-Path $ClaudeHome 'skill-backups'

if (-not (Test-Path (Join-Path $Src 'SKILL.md'))) {
    Write-Host 'ไม่พบ skill\ecmis\SKILL.md — กรุณาแตกไฟล์ zip ให้ครบก่อนรัน (อย่ารันจากในไฟล์ zip โดยตรง)' -ForegroundColor Red
    exit 1
}

Write-Host '== ติดตั้ง skill /ecmis =='
New-Item -ItemType Directory -Force -Path (Join-Path $ClaudeHome 'skills') | Out-Null
if (Test-Path $Dest) {
    New-Item -ItemType Directory -Force -Path $BackupRoot | Out-Null
    $Bk = Join-Path $BackupRoot ('ecmis-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
    Move-Item -Path $Dest -Destination $Bk
    Write-Host "• สำรองของเดิมไว้ที่ $Bk"
}
Copy-Item -Path $Src -Destination $Dest -Recurse
Write-Host "ติดตั้ง skill แล้วที่ $Dest" -ForegroundColor Green

Write-Host ''
Write-Host '== ตรวจตัวแปลงเอกสาร (Python + markitdown) =='

# หา Python 3.10+ (ข้าม python.exe ตัวหลอกของ Microsoft Store ที่รันไม่ได้จริง)
$Py = $null
$Candidates = @(
    @{ Exe = 'py';      Pre = @('-3') },
    @{ Exe = 'python';  Pre = @() },
    @{ Exe = 'python3'; Pre = @() }
)
foreach ($c in $Candidates) {
    if (-not (Get-Command $c.Exe -ErrorAction SilentlyContinue)) { continue }
    try {
        $pre = $c.Pre
        & $c.Exe @pre -c 'import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)' 2>$null
        if ($LASTEXITCODE -eq 0) { $Py = $c; break }
    } catch {}
}

$Script = Join-Path $Dest 'scripts\convert_docs.py'
function Invoke-Py {
    $pre = $Py.Pre
    & $Py.Exe @pre @args
}
function Test-Deps {
    Invoke-Py $Script '.' '--check-deps' *> $null
    return ($LASTEXITCODE -eq 0)
}

if (-not $Py) {
    Write-Host 'ไม่พบ Python 3.10 ขึ้นไป — skill ติดตั้งแล้ว แต่ต้องติดตั้ง Python ก่อนใช้งาน' -ForegroundColor Yellow
    Write-Host '   ติดตั้งจาก https://www.python.org/downloads/ (ติ๊ก "Add python.exe to PATH")'
    Write-Host '   แล้วรัน install.cmd อีกครั้ง'
} else {
    $PyLabel = (@($Py.Exe) + $Py.Pre) -join ' '
    if (Test-Deps) {
        Write-Host "markitdown พร้อมใช้งาน ($PyLabel)" -ForegroundColor Green
    } else {
        Write-Host "• กำลังติดตั้ง markitdown และ pypdf ด้วย $PyLabel ..."
        $ErrorActionPreference = 'Continue'
        Invoke-Py -m pip install -q --user --upgrade 'markitdown[all]' pypdf
        if ($LASTEXITCODE -ne 0) { Invoke-Py -m pip install -q --upgrade 'markitdown[all]' pypdf }
        $ErrorActionPreference = 'Stop'
        if (Test-Deps) {
            Write-Host 'ติดตั้ง markitdown สำเร็จ' -ForegroundColor Green
        } else {
            Write-Host 'ติดตั้ง markitdown ไม่สำเร็จ — skill ใช้งานได้ และจะเสนอให้ติดตั้งอีกครั้งตอนสั่ง /ecmis' -ForegroundColor Yellow
            Write-Host "   หรือติดตั้งเอง: $PyLabel -m pip install `"markitdown[all]`" pypdf"
        }
    }
}

Write-Host ''
Write-Host '== ขั้นต่อไป =='
Write-Host '1. คัดลอกโฟลเดอร์ project\ecmis-trace ไปไว้ที่ที่ต้องการ'
Write-Host '2. วางเล่มเอกสารใน ecmis-trace\input\docs\'
Write-Host '3. เปิด Claude Code ในโฟลเดอร์ ecmis-trace แล้วสั่ง /ecmis <เลข Activity> เช่น /ecmis 5'
