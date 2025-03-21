# block and unblock sites

param([string]$command)

# blocking sites lists updated in github: https://github.com/blocklistproject/Lists
$site_lists = "
127.0.0.1 facebook.com
127.0.0.1 x.com
127.0.0.1 reddit.com
127.0.0.1 youtube.com
127.0.0.1 music.youtube.com
127.0.0.1 spotify.com 
127.0.0.1 music.apple.com
127.0.0.1 tiktok.com
127.0.0.1 chromewebstore.google.com
"

function block {
    $isExist=(test-path "C:\Windows\System32\drivers\etc\hosts_backup")

    # creates backup
    if(-not($isExist)) {
        cp -force "C:\windows\System32\drivers\etc\hosts" "C:\windows\System32\drivers\etc\hosts_backup"
    }

    # iterate the object
    ac -path C:\Windows\System32\drivers\etc\hosts -value $site_lists
}

function unblock {
    $isExist=(test-path "C:\Windows\System32\drivers\etc\hosts_backup")

    if(-not($isExist)) {
        New-Item -Name hosts -ItemType File
    } else {
        cp -force "C:\windows\System32\drivers\etc\hosts_backup" "C:\windows\System32\drivers\etc\hosts"
    }
}


function Interactive-Menu {
    param([Object[]]$inputs)
    do {
        cls         
        echo "                __________________________________________________________________________________________`n
                                               Blocking and Unblocking Sites                                `n
                         [1] - Block                                                                        `n
                         [2] - Unblock                                                                      `n
                         [q] - Exit                                                                         `n
                    __________________________________________________________________________________________`n"
    
        if (-not($inputs)) { 
            $inputs = @()
            $inputs += read-host "                Enter selection" 
        }
        
        foreach ($input in $inputs) {
            switch($input) {
                '1' {
                    cls
                    echo "Please wait..."
                    block        
                    echo "Successfullty blocked."
                    $inputs = $inputs -ne $input
                    sleep 3
                }
                '2' {
                    cls
                    echo "Please wait..."
                    unblock       
                    echo "Successfullty unblocked."
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