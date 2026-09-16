Write-Host "[*] Dang bat toi uu Audit Policy cho SOC..." -ForegroundColor Cyan

# 1. Nhom Account Logon & Logon/Logoff (Xac thuc, Brute-force)
auditpol /set /subcategory:"Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Logoff" /success:enable /failure:disable
auditpol /set /subcategory:"Special Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Account Lockout" /success:enable /failure:enable
auditpol /set /subcategory:"Credential Validation" /success:enable /failure:enable
auditpol /set /subcategory:"Other Logon/Logoff Events" /success:enable /failure:enable

# 2. Nhom Account Management (Tao/Sua/Xoa user, nhet vao Admin)
auditpol /set /subcategory:"User Account Management" /success:enable /failure:enable
auditpol /set /subcategory:"Security Group Management" /success:enable /failure:enable
auditpol /set /subcategory:"Other Account Management Events" /success:enable /failure:enable

# 3. Nhom Detailed Tracking (Process Creation - 4688)
auditpol /set /subcategory:"Process Creation" /success:enable /failure:disable
auditpol /set /subcategory:"Process Termination" /success:disable /failure:disable

# 4. Nhom Policy Change & Privilege Use (Leo quyen, sua audit)
auditpol /set /subcategory:"Audit Policy Change" /success:enable /failure:enable
auditpol /set /subcategory:"Authentication Policy Change" /success:enable /failure:enable
auditpol /set /subcategory:"Sensitive Privilege Use" /success:enable /failure:enable

# 5. Nhom System (Cai dat Service, Driver, Shutdown)
auditpol /set /subcategory:"Security State Change" /success:enable /failure:enable
auditpol /set /subcategory:"Security System Extension" /success:enable /failure:enable
auditpol /set /subcategory:"System Integrity" /success:enable /failure:enable

# 6. Bat Command Line Logging cho Event 4688 (Quan trong nhat)
Write-Host "[*] Dang kich hoat Process Creation CommandLine Logging vao Registry..." -ForegroundColor Yellow
$regPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit"
if (!(Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }
Set-ItemProperty -Path $regPath -Name "ProcessCreationIncludeCmdLine_Enabled" -Value 1 -Type DWord -Force

Write-Host "[+] HOAN TAT TOI UU AUDIT POLICY CHO SOC LAB!" -ForegroundColor Green
