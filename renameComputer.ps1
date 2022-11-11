# 1.1 To rename your local computer on Windows Server 2019 you must enter your new name inside the qutoations.
# 1.2 In my example I named my AD server dc01.
# 2.1 Provide your local credentials, in my example I created a local admin account called "admin". 
# 2.2 You will then be prompted to enter in your password.
# 3.1 You can pass in the -Restart parameter at the end of the command, but only use it if you know you can restart your
# 3.2 server right away in production environments. You will need to restart your server for the new name to take effect. 

Rename-Computer -Newname "dc01" -LocalCredential admin
