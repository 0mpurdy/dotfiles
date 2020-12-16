# Windows configuration

## Windows subsystem for Linux

Install [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10#complete-initialization-of-your-distro) so that you don't have to use windows.

If you don't have access to the store, you can [download the package manually](https://docs.microsoft.com/en-us/windows/wsl/install-manual) and [extract it](https://docs.microsoft.com/en-us/windows/wsl/install-on-server).

Other useful links:

 - [Initialising WSL](https://docs.microsoft.com/en-us/windows/wsl/initialize-distro)

## Dotfiles

You can push and pull the windows dotfiles using the script in `win/scripts` of this repo.

## Selenium webdriver fix

Selenium web driver sometimes fails: workaround:

```powershell
Get-Item 'HKLM:\System\CurrentControlSet\Services\Tcpip\Parameters' | New-ItemProperty -Name MaxUserPort -Value 65534 -Force | Out-Null
Get-Item 'HKLM:\System\CurrentControlSet\Services\Tcpip\Parameters' | New-ItemProperty -Name TcpTimedWaitDelay -Value 30 -Force | Out-Null
Get-Item 'HKLM:\System\CurrentControlSet\Services\Tcpip\Parameters' | New-ItemProperty -Name TcpNumConnections -Value 16777214 -Force | Out-Null
Get-Item 'HKLM:\System\CurrentControlSet\Services\Tcpip\Parameters' | New-ItemProperty -Name TcpMaxDataRetransmissions -Value 5 -Force | Out-Null
```
