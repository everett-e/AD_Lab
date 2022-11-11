# Get the members of a distribution group and export to a csv file.
Get-DistributionGroupMember -Identity "dggroup1" | Export-csv -path c:\\dell\dggroup1.csv -NoTypeInformation
