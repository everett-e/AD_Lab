# Replace 'C:\Path\To\Your\Directory' with the actual path to your root directory
$rootPath = 'C:\Path\To\Your\Directory'
$outputCsv = 'C:\Path\To\Your\Output\File.csv'

# Get all the second-level folders in the root directory
$secondLevelFolders = Get-ChildItem -Path $rootPath -Directory | Get-ChildItem -Directory

# Create an array to store the data
$data = @()

# Loop through the second-level folders and get their permissions
foreach ($folder in $secondLevelFolders) {
    $folderName = $folder.Name
    $folderPath = $folder.FullName
    $acl = Get-Acl -Path $folderPath

    # Loop through each ACE (Access Control Entry) in the ACL and extract relevant information
    foreach ($ace in $acl.Access) {
        $accessType = $ace.FileSystemRights
        $identity = $ace.IdentityReference.Value
        $permission = $ace.AccessControlType

        # Determine whether the identity is a user or group
        $isGroup = $identity -cmatch '^\w+\\'

        # Create a custom PowerShell object to store the data for each folder
        $folderData = [PSCustomObject]@{
            FolderName = $folderName
            Identity = $identity
            IdentityType = if ($isGroup) { 'Group' } else { 'User' }
            AccessType = $accessType
            Permission = $permission
        }

        # Add the folder data to the main data array
        $data += $folderData
    }
}

# Export the data to a CSV file
$data | Export-Csv -Path $outputCsv -NoTypeInformation

Write-Host "Permissions data has been exported to $outputCsv."
