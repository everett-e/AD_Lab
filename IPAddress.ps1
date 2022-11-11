# Setting the IP address of one of your NICs on your machine through powershell requires you to know what NIC adapter you want use AKA IP Interface.
# To see your machine's IP Interfaces run the following command:

Get-NetIPInterface

# You should see a number next to the IPv4 interface that you wish to use in the IF Index column.
# Now to set the IP of that IP interface use the following command with the associated IP Interface index number (Mine is 4, yours may be different)
# Pass in your IP address along with the subnet mask(PrefixLength) and your DefaultGateway (DGW):

New-NetIPAddress -InterfaceIndex 4 -IPAddress 10.1.1.20 -PrefixLength 24 -DefaultGateway 10.1.1.1

# Setting your DNS Server - Once again you need to specify your IP Interface (InterfaceIndex)
# You can pass in a single address, but if you want to pass in multiple they need to be in parenthesis and you need to use double quotes.

Set-DnsClientServerAddress -InterfaceIndex 4 -ServerAddresses ("10.1.1.100","8.8.8.8")

# Run an ipconfig /all to verify settings.
