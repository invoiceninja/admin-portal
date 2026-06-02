<#
.SYNOPSIS
  Upload Windows debug symbols (PDB) to Sentry and assemble a Partner Center
  .msixupload (MSIX + .appxsym) so native Windows crashes symbolicate.

.DESCRIPTION
  Run on the Windows build machine from the repo root AFTER:
      flutter build windows --release
  This script:
    1. Locates the Release output and the runner PDB(s).
    2. Uploads symbols to the self-hosted Sentry (sentry-cli debug-files upload).
    3. Builds <name>.appxsym (zip of PDBs) and a lean store MSIX (no PDB inside).
    4. Builds <name>.<version>.x64.msixupload (MSIX + appxsym) for Partner Center.

  Symbols match by debug-id (GUID+age), so always run this against the PDB from
  the SAME build that produced the submitted exe.

.PARAMETER Version
  Version string used in the .msixupload file name (defaults to 5.0.197).

.PARAMETER Org
  Sentry organization slug (required for the Sentry upload).

.PARAMETER Project
  Sentry project slug (required for the Sentry upload). The DSN project id is 3.

.PARAMETER SkipSentry
  Skip the Sentry upload (only build the Partner Center .msixupload).

.EXAMPLE
  $env:SENTRY_URL = "https://sentry2.invoicing.co"
  $env:SENTRY_AUTH_TOKEN = "<token>"
  ./windows/package_symbols.ps1 -Version 5.0.197 -Org <org> -Project <project>
#>
param(
  [string]$Version = "5.0.197",
  [string]$Org,
  [string]$Project,
  [switch]$SkipSentry
)

$ErrorActionPreference = "Stop"
$name = "invoiceninja"

# 1. Locate the Release output (newer Flutter uses the x64 subfolder).
$rel = if (Test-Path "build\windows\x64\runner\Release") {
  "build\windows\x64\runner\Release"
} elseif (Test-Path "build\windows\runner\Release") {
  "build\windows\runner\Release"
} else {
  throw "Release output not found. Run 'flutter build windows --release' first."
}
Write-Host "Release dir: $rel"

$pdbs = Get-ChildItem "$rel\*.pdb" -ErrorAction SilentlyContinue
if (-not $pdbs) {
  throw "No .pdb found in $rel. Confirm the PDB flags in windows/runner/CMakeLists.txt are applied."
}
Write-Host ("Found PDB(s): " + ($pdbs.Name -join ", "))

$out = "build\windows\upload"
$sym = "$out\symbols"
New-Item -ItemType Directory -Force -Path $out, $sym | Out-Null

# Stage the PDB(s) out of the Release folder so they are NOT packed into the MSIX.
Copy-Item "$rel\*.pdb" $sym -Force

# 2. Upload symbols to Sentry (matched by debug-id).
if (-not $SkipSentry) {
  if (-not $Org -or -not $Project) {
    throw "Sentry upload needs -Org and -Project (or pass -SkipSentry). DSN project id is 3."
  }
  if (-not $env:SENTRY_AUTH_TOKEN) {
    throw "Set SENTRY_AUTH_TOKEN (and SENTRY_URL=https://sentry2.invoicing.co) before uploading."
  }
  if (-not $env:SENTRY_URL) { $env:SENTRY_URL = "https://sentry2.invoicing.co" }
  Write-Host "Uploading symbols to Sentry ($env:SENTRY_URL) org=$Org project=$Project ..."
  & sentry-cli debug-files upload --org $Org --project $Project $rel
  if ($LASTEXITCODE -ne 0) { throw "sentry-cli upload failed (exit $LASTEXITCODE)." }
}

# 3. Build the .appxsym (a renamed zip of the PDBs).
$appxsym = "$out\$name.appxsym"
if (Test-Path $appxsym) { Remove-Item $appxsym -Force }
Compress-Archive -Path "$sym\*.pdb" -DestinationPath "$out\tmp.zip" -Force
Move-Item "$out\tmp.zip" $appxsym -Force
Write-Host "Built $appxsym"

# Re-create a LEAN store MSIX with the PDBs removed from the Release folder.
Remove-Item "$rel\*.pdb" -Force
Write-Host "Re-creating lean store MSIX (dart run msix:create) ..."
& dart run msix:create
if ($LASTEXITCODE -ne 0) { throw "dart run msix:create failed (exit $LASTEXITCODE)." }

$msix = "$rel\$name.msix"
if (-not (Test-Path $msix)) { throw "Expected MSIX not found at $msix." }

# 4. Build the .msixupload (a renamed zip of the MSIX + the appxsym).
$upload = "$out\$name.$Version.x64.msixupload"
if (Test-Path $upload) { Remove-Item $upload -Force }
Compress-Archive -Path $msix, $appxsym -DestinationPath "$out\tmp.zip" -Force
Move-Item "$out\tmp.zip" $upload -Force

Write-Host ""
Write-Host "Done. Upload to Partner Center: $upload"
