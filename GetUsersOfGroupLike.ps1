# Get users who are in a group that start with "test"
Get-ADGroup -Filter "Name -like 'test*'" | foreach { 
    $groupName = $_.Name 
    Get-ADGroupMember -Identity $_.SamAccountName |
        Select @{N='GroupName';E={$groupName}},SamAccountName,Name 
} | Export-csv -Path c:\Dell\testMembers.csv -NoTypeInformation
