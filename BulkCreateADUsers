# Use this powershell script to create a set of dummy accounts that you can work with quickly.
$path="OU=IT,DC=Test,DC=com"
$username="ITuser"
$count=1..10
foreach ($i in $count)
{ New-AdUser -Name $username$i -Path $path -Enabled $True -ChangePasswordAtLogon $true -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -force) -passThru }
