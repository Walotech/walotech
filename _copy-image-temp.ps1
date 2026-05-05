$ErrorActionPreference = "Continue"
Write-Host "--- 1. New-Item ---"
try {
  New-Item -ItemType Directory -Force -Path "C:\Users\LENOVO\Projects\walotech\images" | Out-Null
  Write-Host "SUCCESS: Directory created or exists"
} catch {
  Write-Host "FAILURE:" $_.Exception.Message
  Write-Host $_.ScriptStackTrace
}

Write-Host "--- 2. Copy-Item ---"
$src = "C:\Users\LENOVO\.cursor\projects\c-Users-LENOVO-Projects-walotech\assets\c__Users_LENOVO_AppData_Roaming_Cursor_User_workspaceStorage_6f84edcf9807d45540dfa2201813300f_images_image-f41ef3c6-5a42-45bc-bee7-7ca5c164b55f.png"
$dest = "C:\Users\LENOVO\Projects\walotech\images\perrito-mecanico.png"
if (-not (Test-Path -LiteralPath $src)) {
  Write-Host "Source missing; searching..."
  $found = Get-ChildItem -Path "C:\Users\LENOVO\.cursor\projects" -Recurse -Filter "image-f41ef3c6*.png" -File -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($found) {
    $src = $found.FullName
    Write-Host "Using:" $src
  } else {
    Write-Host "No fallback image found"
  }
}
try {
  if (Test-Path -LiteralPath $src) {
    Copy-Item -LiteralPath $src -Destination $dest -Force
    Write-Host "SUCCESS: Copy completed"
  } else {
    Write-Host "FAILURE: Source path does not exist:" $src
  }
} catch {
  Write-Host "FAILURE:" $_.Exception.Message
  Write-Host $_.ScriptStackTrace
}

Write-Host "--- 3. Test-Path ---"
$exists = Test-Path -LiteralPath $dest
Write-Host "Test-Path result:" $exists

if ($exists) {
  $len = (Get-Item -LiteralPath $dest).Length
  Write-Host "Size bytes:" $len
} else {
  Write-Host "Size bytes: N/A"
}
