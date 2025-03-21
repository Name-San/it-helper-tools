param([string]$command)

function Interactive-Menu {
    param([Object[]]$inputs)
    do {
        cls         
        echo "              __________________________________________________________________________________________`n
                                                Microsoft Store Access Control                              `n
                            [1] Disable Service                                                             `n
                            [2] Enable Service                                                              `n
                            [q] Exit                                                                        `n
                  __________________________________________________________________________________________`n"
    
        if (-not($inputs)) { 
            $inputs = @()
            $inputs += read-host "                Enter selection" 
        }
        
        foreach ($input in $inputs) {
            switch($input) {
                '1' {
                    Stop-Service -Name "InstallService" -Force
                    Set-Service -Name "InstallService" -StartupType Disabled
                    
                    echo "`n                Microsoft Store disabled successfully."
                    $inputs = $inputs -ne $input
                    sleep 3
                } '2' {
                    Set-Service -Name "InstallService" -StartupType Manual
                    Start-Service -Name "InstallService" 
        
                    echo "`n                Microsoft Store enabled successfully."
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

    if ($command) {
        switch ($command) {
            '/disable' {
                Interactive-Menu @("1", "q")
            } 
            '/enable' {
                Interactive-Menu @("2", "q")
            }
            default {
                Write-Ouput "Invalid command. Use /disable or /enable"
            }
        }
    } else {
        Interactive-Menu
    }
}

Main $command
CLS