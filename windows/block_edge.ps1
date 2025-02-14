# Define the path to the program you want to block
$programPath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$ruleName = "Block MSEdge"

do {
    cls         
    echo "              __________________________________________________________________________________________`n
                                             Microsoft Edge Access Control                              `n
                        [1] Block Edge                                                                  `n
                        [2] Allow Edge                                                                  `n
                        [q] Exit                                                                        `n
              __________________________________________________________________________________________`n"

    $input = read-host "                Enter selection"
    switch($input) {
        '1' {
            # Create a new outbound firewall rule to block the program
            New-NetFirewallRule -DisplayName "Block MSEdge" -Direction Outbound -Program $programPath -Action Block
            echo "`n                Successfully blocked."
            sleep 3
        } '2' {
            # Remove the firewall rule
            Remove-NetFirewallRule -DisplayName $ruleName
            echo "`n                Enabled successfully."
            sleep 3
        } 'q' {
            exit
        }
    }
} until ($input -eq 0)
