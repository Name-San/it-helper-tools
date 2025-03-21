param([string]$command)

$programPath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$ruleName = "Block MSEdge"

function Interactive-Menu {
    param([Object[]]$inputs)
    do {
        cls      
        echo "              __________________________________________________________________________________________`n
                                                 Microsoft Edge Access Control                              `n
                            [1] Block Edge                                                                  `n
                            [2] Allow Edge                                                                  `n
                            [q] Exit                                                                        `n
                  __________________________________________________________________________________________`n"
        if (-not($inputs)) {
            $inputs = @()
            $inputs += read-host "                Enter selection"
        }

        foreach ($input in $inputs) {
            switch($input) {
                '1' {
                    # Create a new outbound firewall rule to block the program
                    New-NetFirewallRule -DisplayName "Block MSEdge" -Direction Outbound -Program $programPath -Action Block
                    echo "`n                Successfully blocked."
		            $inputs = $inputs -ne $input
                    sleep 3
                } '2' {
                    # Remove the firewall rule
                    Remove-NetFirewallRule -DisplayName $ruleName
                    echo "`n                Enabled successfully."
		            $inputs = $inputs -ne $input
                    sleep 3
                } 'q' {
                    $input = 0
                }
            }
        }
    } until ($input -eq 0)
}

function Main {
param([string]$command)
if($command) {
    switch ($command) {
        '/disable' {
            Interactive-Menu @("1", "q")
        }
        '/enable' {
            Interactive-Menu @("2", "q")
        }
        default {
            Write-Output "Invalid command. Use /disable or /enable."
        }
    }
} else {
    Interactive-Menu
}
}

Main $command