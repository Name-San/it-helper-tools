# IT Helper Tools 
_Simple tools to assist your daily tasks. Please read the instruction below how to use it._

## How to use it?
1. We will be following this command format: ```irm <link> | iex ```.
2. Make sure to Open PowerShell (Not CMD). To do that, right-click on the Windows start menu and select PowerShell or Terminal.


| Task | Command | Link |
| --- | --- | --- |
| Add Chrome Policies| ``` irm https://name-san.github.io/it-helper-tools/windows/add_chrome_policies.txt \| iex ``` | [Link](https://name-san.github.io/it-helper-tools/windows/add_chrome_policies.txt) |
| Block Edge | ``` irm https://name-san.github.io/it-helper-tools/windows/block_edge.txt \| iex ``` | [Link](https://name-san.github.io/it-helper-tools/windows/block_edge.txt) |
| Disable Store | ``` irm https://name-san.github.io/it-helper-tools/windows/disable_store.txt \| iex ``` | [Link](https://name-san.github.io/it-helper-tools/windows/disable_store.txt) |
| Set IP | ``` irm https://name-san.github.io/it-helper-tools/windows/set_ip.txt \| iex ``` | [Link](https://name-san.github.io/it-helper-tools/windows/set_ip.txt) |
<br/>

> [!NOTE]
> - The IRM command in PowerShell downloads a script from a specified URL, and the IEX command executes it.
> - Always double-check the URL before executing the command and verify the source if manually downloading files.
> - You can check the code by accessing the links.

## Use Powershell One Liner
``` & ([ScriptBlock]::Create((irm <link>))) /para ```
- Select your desired link given from the above table and replace ``` <link> ``` 
- Replace /para in this command with the available switches in the table below. 
- This Powershell one-liner will work on Windows 8.1 and later versions only.

## Switches
| Param | Description |
| --- | --- |
| /disable | Disable all functions related describe in the tool |
| /enable | Enable all functions related describe in the tool |
