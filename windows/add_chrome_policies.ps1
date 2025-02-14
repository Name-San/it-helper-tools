
function Add-Policies {
    param(
        [int]$incognito,
        [int]$guest,
        [int]$sync,
        [int]$history
    )
    $Path = "HKLM:\SOFTWARE\Policies\Google\Chrome"
    $Entries = @{
        "IncognitoModeAvailability"=$incognito
        "BrowserGuestModeEnabled"=$guest
        "SyncDisabled"=$sync
        "AllowDeletingBrowserHistory"=$history
    }

    foreach ($Entry in $Entries.GetEnumerator()) {
        New-ItemProperty -Path $Path -Name $Entry.Key -Value $Entry.Value -PropertyType DWORD -Force 
    }

    echo "Successfully Applied."
    sleep 3
}

do {
    cls         
    echo "              __________________________________________________________________________________________`n
                                                Chrome Policies Activation                              `n
                        [1] Disable Manually                                                            `n
                        [2] Disable All                                                                 `n
                        [3] Allow All                                                                   `n
                        [q] Exit                                                                        `n
              __________________________________________________________________________________________`n"

    $input = read-host "                Enter selection"
    switch($input) {
        '1' {
            cls
            echo "              __________________________________________________________________________________________`n
                                                0 = True | 1 = False                                    `n"
            $incognito = read-host "                Incognito Mode Availability"
            $guest = read-host "                Browser Guest Mode Disable"
            $sync = read-host "                Sync Enable"
            $history = read-host "                Disable Deleting Browser History"
            echo "Please wait..."
            Add-Policies -incognito $incognito -guest $guest -sync $sync -history $history
        } '2' {
            Add-Policies -incognito 1 -guest 0 -sync 1 -history 0
        } '3' {
            Add-Policies -incognito 0 -guest 1 -sync 0 -history 1
        }
        'q' {
            exit
        }
    }
} until ($input -eq 0)
