# Define the directory path and the username you want to grant permissions to
$directoryPath = "C:\Your\Directory\Path"
$username = "YourUsername"

# Get the Security Principal for the specified username
$user = New-Object System.Security.Principal.NTAccount($username)

# Define the permission level (FullControl)
$permission = [System.Security.AccessControl.FileSystemRights]::FullControl

# Inheritance and propagation flags
$inheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit, [System.Security.AccessControl.InheritanceFlags]::ObjectInherit
$propagationFlag = [System.Security.AccessControl.PropagationFlags]::None

# Get the Access Control List (ACL) for the directory
$acl = Get-Acl -Path $directoryPath

# Create an Access Rule for the user
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, $permission, $inheritanceFlag, $propagationFlag, "Allow")

# Add the Access Rule to the ACL
$acl.AddAccessRule($rule)

# Set the modified ACL to the directory
Set-Acl -Path $directoryPath -AclObject $acl

# Recursively apply the permission to all subfolders and files
Get-ChildItem -Path $directoryPath -Recurse | ForEach-Object {
    Set-Acl -Path $_.FullName -AclObject $acl
}

Write-Host "Permissions granted to $username on $directoryPath and its subfolders."
