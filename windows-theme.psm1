. "$PSScriptRoot\windows-theme.ps1"

Set-Alias -Name 'win-theme-default' -Value Use-WindowsDefaultTheme
Set-Alias -Name 'win-theme-inverted' -Value Use-WindowsInvertedTheme
Set-Alias -Name 'win-theme-light' -Value Use-WindowsLightTheme
Set-Alias -Name 'win-theme-dark' -Value Use-WindowsDarkTheme

$moduleMember = @{
    Function = @(
        'Get-WindowsTheme',
        'Set-WindowsTheme',
        'Get-WindowsAppsTheme',
        'Set-WindowsAppsTheme',
        'Get-WindowsSystemTheme',
        'Set-WindowsSystemTheme',
        'Use-WindowsDefaultTheme',
        'Use-WindowsInvertedTheme',
        'Use-WindowsLightTheme',
        'Use-WindowsDarkTheme'
    )
    Alias = @(
        'win-theme-default',
        'win-theme-inverted',
        'win-theme-light',
        'win-theme-dark'
    )
}

Export-ModuleMember @moduleMember