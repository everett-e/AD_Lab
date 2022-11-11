# Use this powershell script to get a list of Users in a specific security group and export the list to a csv file. 
Get-ADGroupMember -identity “Security Group” | select name | Export-csv -path C:\it\filename.csv -NoTypeInformation
