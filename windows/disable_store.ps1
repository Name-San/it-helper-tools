do {
    cls         
    echo "              __________________________________________________________________________________________`n
                                            Microsoft Store Access Control                              `n
                        [1] Disable Service                                                             `n
                        [2] Enable Service                                                              `n
                        [q] Exit                                                                        `n
              __________________________________________________________________________________________`n"

    $input = read-host "                Enter selection"
    switch($input) {
        '1' {
            Stop-Service -Name "InstallService" -Force
            Set-Service -Name "InstallService" -StartupType Disabled
            
            echo "`n                Microsoft Store disabled successfully."
            sleep 3
        } '2' {
            Set-Service -Name "InstallService" -StartupType Manual
            Start-Service -Name "InstallService" 

            echo "`n                Microsoft Store enabled successfully."
            sleep 3
        } 'q' {
            exit
        }
    }
} until ($input -eq 0)
