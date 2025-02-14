# block and unblock sites

# blocking sites lists updated in github: https://github.com/blocklistproject/Lists
$site_lists = [PSCustomObject]@{
    abuse = "https://blocklistproject.github.io/Lists/abuse.txt"
    ads = "https://blocklistproject.github.io/Lists/ads.txt"
    crypto = "https://blocklistproject.github.io/Lists/crypto.txt"
    drugs = "https://blocklistproject.github.io/Lists/drugs.txt"
    fb = "https://blocklistproject.github.io/Lists/facebook.txt"
    fraud = "https://blocklistproject.github.io/Lists/fraud.txt"
    gambling = "https://blocklistproject.github.io/Lists/gambling.txt"
    malware = "https://blocklistproject.github.io/Lists/malware.txt"
    phising = "https://blocklistproject.github.io/Lists/phishing.txt"
    piracy = "https://blocklistproject.github.io/Lists/piracy.txt"
    porn = "https://blocklistproject.github.io/Lists/porn.txt"
    ransomware = "https://blocklistproject.github.io/Lists/piracy.txt"
    redirect = "https://blocklistproject.github.io/Lists/redirect.txt"
    scam = "https://blocklistproject.github.io/Lists/scam.txt"
    tiktok = "https://blocklistproject.github.io/Lists/tiktok.txt"
    torrent = "https://blocklistproject.github.io/Lists/torrent.txt"
    tracking = "https://blocklistproject.github.io/Lists/tracking.txt"
}

function block {
    $isExist=(test-path "C:\Windows\System32\drivers\etc\hosts_backup")

    # creates backup
    if(-not($isExist)) {
        cp -force "C:\windows\System32\drivers\etc\hosts" "C:\windows\System32\drivers\etc\hosts_backup"
    } 

    # implement clean blocking
    if($isExist) {
        cp -force "C:\windows\System32\drivers\etc\hosts_backup" "C:\windows\System32\drivers\etc\hosts"
    }

    # iterate the object
    foreach ($property in $site_lists.PSObject.Properties) {
        # get the content in the given link
        $response = irm -Uri $property.Value
        # append the content in the hosts file
        ac -path C:\Windows\System32\drivers\etc\hosts -value "$response"
    }

    return $true
}

function unblock {
    $isExist=(test-path "C:\Windows\System32\drivers\etc\hosts_backup")

    if(-not($isExist)) {
        return $false
    }

    cp -force "C:\windows\System32\drivers\etc\hosts_backup" "C:\windows\System32\drivers\etc\hosts"
}


do {
    cls         
    echo "                __________________________________________________________________________________________`n
                                           Blocking and Unblocking Sites                                `n
                     [1] - Block                                                                        `n
                     [2] - Unblock                                                                      `n
                     [0] - Exit                                                                         `n
                __________________________________________________________________________________________`n"

    $input = read-host "                Enter selection number"
    switch($input) {
        '1' {
            cls
            echo "Please wait..."
            block        
            echo "Successfullty blocked."
        }
        '2' {
            cls
            echo "Please wait..."
            block        
            echo "Successfullty unblocked."
        }
    }
} until ($input -eq 0)
