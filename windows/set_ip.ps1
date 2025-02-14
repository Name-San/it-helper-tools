# Change default values if needed
function Set-IP {
    # connection lists
    netsh interface show interface

    # ask for user input
    $interface = Read-Host "Enter desired interface name"
    $ip = Read-Host "Enter IP last digits"
    $default_gateway = "192.168.0.1"
    $default_subnet = "255.255.255.0"

    # set ip addres
    netsh interface ip set address name="$interface" static 192.168.0.$ip $default_subnet $default_gateway

    # add dns
    netsh interface ip add dns name="$interface" address=8.8.8.8 index=1
    netsh interface ip add dns name="$interface" address=8.8.4.4 index=2

    echo "Successfully added. Use 'ipconfig' to verify."
}

Set-IP  