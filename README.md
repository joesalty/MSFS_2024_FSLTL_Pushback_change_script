# MSFS_2024_FSLTL_Pushback_change_script
Powershell script to mass update aircraft.cfg files in FSLTL folders in MSFS 2024 to workaround the no traffic issue.

---
## ✅ **1. Save the script as a .ps1 file**
1. Open **Notepad**
2. Paste the full script into it
3. Save as:

edit_pushback.ps1

Make sure the **Save as type** is set to *All Files*, not *.txt*.
---
## ✅ **2. Allow PowerShell to run scripts (one‑time setup)**

Windows blocks scripts by default.  
You need to enable script execution **once**:

1. Right‑click **Start** → choose **Windows PowerShell (Admin)**  
2. Run this command:

Set-ExecutionPolicy RemoteSigned

3. Press **Y** and hit Enter
This allows local scripts to run.
---
## ✅ **3. Run the script**

### Option A — Run from PowerShell directly  
1. Open **PowerShell**
2. Navigate to the folder where your script is saved:

cd C:\path\to\your\script\

3. Run it:

.\edit_pushback.ps1

---

### Option B — Right‑click → “Run with PowerShell”
This works only if execution policy is already set.

- Right‑click the file  
- Select **Run with PowerShell**

---

## 🧠 What happens when you run it
- It scans **all aircraft folders** under your FSLTL directory  
- Creates a **.bak backup** of each `aircraft.cfg`  
- Replaces `PUSHBACK = 1` with `PUSHBACK = 0`  
- Logs everything to:
```
C:\pushback_edit_log.txt
```
By default the script runs in dry-run mode. You have to change the `$dryRun = $true` parameter to `$dryRun = $false` to make the changes.

## 🧠 How dry‑run mode works

- When `$dryRun = $true`  
  - **No files are touched**  
  - No backups created  
  - Log shows:  
    - `DRY-RUN (WOULD CHANGE)`  
    - `DRY-RUN (NO CHANGE)`

- When `$dryRun = $false`  
  - Backups are created  
  - Files are modified  
  - Log shows:  
    - `CHANGED`  
    - `NO CHANGE`

