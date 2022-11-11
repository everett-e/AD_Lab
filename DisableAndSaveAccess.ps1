# The purpose of this it to automatically disable an AD Account and move it to the Terminations OU.
# While at the same time documenting the User's Logon Script and Groups.
# It is good practice to run Get-ADUser on the account you wish to disable before running this script
# to ensure you're disabling the correct account.

# Identify the Account to be disabled. Place only the SamAccountName into Memory.

$Account = Get-ADUser -Identity 'testuser1' | ForEach-Object {$_.SamAccountName}
# Disable AD account
Disable-ADAccount -Identity $Account
# Move AD Account to the Terminations OU
$ADObject = Get-ADUser -Identity $Account
Move-ADObject -Identity $ADObject -TargetPath "OU=Terminations,OU=NoDirectory,OU=Users Accounts,DC=testlab,DC=com"
# Copy logon script and save to a file.
# Create value of the logon script from user profile
$ScriptPath = Get-ADUser -Identity $Account -Properties ScriptPath | ForEach-Object {$_.ScriptPath}
# Get Script contents per script path and save in a text file
Get-Content -Path \\DC01\NETLOGON\$ScriptPath | Out-File -FilePath C:\Dell\Logon$Account.txt -NoClobber
# Groups
# Copy Groups to a file
Get-ADPrincipalGroupMemberShip -Identity $Account | Select-Object name | Out-File -FilePath C:\Dell\Groups$Account.txt -NoClobber

Write-Host "$Account has been disabled and moved to the terminations OU. Navigate to C:\Dell to view Groups and Login Script."
