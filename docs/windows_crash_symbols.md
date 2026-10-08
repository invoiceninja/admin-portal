# Windows crash symbols — Sentry & Partner Center

How to capture and **symbolicate** native Windows crashes for the Invoice Ninja desktop app.
Run every step on the **Windows build machine**, from the repo root, in PowerShell.

Symbols match a build by **debug-id (GUID + age)**, so always upload the PDB produced by the
*same* `flutter build windows --release` that created the exe/MSIX you ship. Older offset-only
crash dumps from builds without symbols can never be retro-symbolicated.

---

## Before you start: is the crash even reaching Sentry?

Native crashes (crashpad minidumps) are uploaded directly and **bypass** the `beforeSend` /
`reportErrors` gate, so they should arrive even when error reporting is off for an account. If you
see *nothing* from Windows in Sentry, check these first (no build needed):

- **Environment filter.** Native minidumps have **no `environment` tag** (it's only set inside
  `beforeSend`, which native crashes skip). In the Sentry UI clear the environment filter and search
  `os.name:Windows`.
- **Dart vs native.** A pure Dart exception *is* gated by `reportErrors`. Enable `report_errors` on
  the affected account to let Dart errors through.
- **Pre-init crash.** A crash before `SentryFlutter.init` arms crashpad cannot be captured.
- **MSIX sandbox.** Confirm crashpad can spawn inside the packaged app (see Verification below).

---

## Prerequisites (one-time)

- Flutter + Visual Studio C++ toolchain (already required to build Windows).
- `sentry-cli`: `scoop install sentry-cli` (or download the binary from the Sentry releases page).
- Sentry values for the self-hosted instance:
  - `SENTRY_URL = https://sentry2.invoicing.co`
  - `SENTRY_AUTH_TOKEN` — create at `sentry2.invoicing.co` → **User settings → Auth Tokens**, with
    scopes `project:read`, `project:releases`, `project:write`.
  - **Org** and **Project** slugs (the DSN exposes only project id `3`; the slug is the name in the URL).

---

## Step 1 — Build with symbols

```powershell
flutter clean
flutter build windows --release
```

Confirm these exist in `build\windows\x64\runner\Release\`:
`invoiceninja.exe`, `invoiceninja.pdb`, `crashpad_handler.exe`, `crashpad_wer.dll`, `sentry.dll`.

If `invoiceninja.pdb` is missing, the PDB flags in `windows/runner/CMakeLists.txt` aren't applied —
re-check that file and rebuild.

---

## Step 2 — Upload symbols to Sentry

```powershell
$env:SENTRY_URL = "https://sentry2.invoicing.co"
$env:SENTRY_AUTH_TOKEN = "<token>"
sentry-cli debug-files upload --org <ORG> --project <PROJECT> build\windows\x64\runner\Release
```

- `sentry-cli` scans the folder, finds `invoiceninja.pdb` (+ exe) and uploads them by debug-id.
- Verify: `sentry-cli debug-files check build\windows\x64\runner\Release\invoiceninja.pdb`, or in the
  Sentry UI: **Settings → Projects → <project> → Debug Files** — the PDB should appear with a debug id.

---

## Step 3 — Build the Partner Center upload (`.appxsym` + `.msixupload`)

```powershell
# a) stage the PDB out so it is NOT packed into the shipped MSIX
mkdir build\windows\upload\symbols -Force
copy build\windows\x64\runner\Release\*.pdb build\windows\upload\symbols\
del build\windows\x64\runner\Release\*.pdb

# b) create the lean store MSIX (no pdb inside)
dart run msix:create

# c) .appxsym = zip of the PDB(s), renamed
Compress-Archive build\windows\upload\symbols\*.pdb build\windows\upload\tmp.zip -Force
move build\windows\upload\tmp.zip build\windows\upload\invoiceninja.appxsym -Force

# d) .msixupload = zip of the .msix + the .appxsym, renamed
Compress-Archive build\windows\x64\runner\Release\invoiceninja.msix,build\windows\upload\invoiceninja.appxsym build\windows\upload\tmp.zip -Force
move build\windows\upload\tmp.zip build\windows\upload\invoiceninja.5.0.197.x64.msixupload -Force
```

> **Tip:** `windows\package_symbols.ps1` automates Steps 2–3. From the repo root:
> ```powershell
> $env:SENTRY_URL = "https://sentry2.invoicing.co"; $env:SENTRY_AUTH_TOKEN = "<token>"
> ./windows/package_symbols.ps1 -Version 5.0.197 -Org <ORG> -Project <PROJECT>
> ```
> Add `-SkipSentry` to build only the `.msixupload`.

---

## Step 4 — Upload to Microsoft Partner Center

1. Sign in to **partner.microsoft.com** → **Apps and games** → **Invoice Ninja**.
2. Start a new **submission** (or edit the pending one) → **Packages**.
3. Upload `invoiceninja.5.0.197.x64.msixupload`. Partner Center extracts the bundled `.appxsym`
   automatically — there is no separate symbol-upload step.
4. Complete and **submit**. After it publishes and crashes are reported, symbolicated stacks appear
   under **Health → Failures** (crash data lags submission by hours–days).

---

## Verification

1. `flutter clean && flutter build windows --release`.
2. Release dir contains the exe, `invoiceninja.pdb`, `crashpad_handler.exe`, `crashpad_wer.dll`, `sentry.dll`.
3. Temporary diagnostic build with `options.debug = true` in `lib/main.dart`: launch, confirm native
   sentry/crashpad init in the console, then trigger a deliberate native crash and confirm an event
   appears in Sentry (offset-only before symbols are uploaded). Revert `options.debug` afterward.
4. Run `windows\package_symbols.ps1`; confirm the PDB is listed under Sentry → Debug Files and that
   `invoiceninja.<version>.x64.msixupload` is produced.
5. Re-open the test crash in Sentry → the stack is now **symbolicated**.
6. Submit the `.msixupload`; after processing, **Health → Failures** shows symbolicated Store dumps.
7. Unzip the shipped `.msix` and confirm it contains `crashpad_handler.exe` but **not** `invoiceninja.pdb`.

---

## Notes & limits

- These symbols cover the **runner + statically-linked native plugin** frames. Crashes inside the
  Flutter **engine** (`flutter_windows.dll`) need Google's symbol server; pure **Dart** frames come
  through the Dart SDK path, not these PDBs.
- x64 only. An arm64 build would use the breakpad backend and need a separate symbol flow.
- Keep the shipped MSIX lean: never leave a `.pdb` in the Release folder when running the final
  `msix:create` (the packager includes the whole folder).
