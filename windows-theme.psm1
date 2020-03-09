$keyPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize'
$appsThemeKeyName = 'AppsUseLightTheme'
$systemThemeKeyName = 'SystemUsesLightTheme'

$lightTheme = 'light'
$darkTheme = 'dark'

Function themeToRegistryValue {
    Param (
        [ValidateSet( 'light', 'dark' )]
        [string] $theme
    )

    if ($theme -eq $lightTheme) {
        1
    } 
    else {
        0
    }
}

Function registryValueToTheme {
    Param (
        [ValidateSet(0, 1)]
        [int] $value
    )

    if ($value -eq 1) {
        $lightTheme
    } else {
        $darkTheme
    }
}

Function Get-PersonalizeRegistry {
    Param (
        [string] $Key
    )

    return (Get-ItemProperty -Path $keyPath -Name $Key).($Key);
}

Function Set-PersonalizeRegistry {
    Param (
        [string] $Key,
        $Value
    )

    New-ItemProperty -Path $keyPath -Name $Key -Value $Value -Type Dword -Force | out-null
}

Function Get-WindowsAppsTheme {
    return (registryValueToTheme (Get-PersonalizeRegistry $appsThemeKeyName))
}

Function Set-WindowsAppsTheme {
    Param (
        [ValidateSet( 'light', 'dark' )]
        [string] $value
    )

    Set-PersonalizeRegistry -Key $appsThemeKeyName -Value (themeToRegistryValue $value)
}

Function Get-WindowsSystemTheme {
    return (registryValueToTheme (Get-PersonalizeRegistry $systemThemeKeyName))
}

Function Set-WindowsSystemTheme {
    Param (
        [ValidateSet( 'light', 'dark' )]
        [string] $value
    )

    Set-PersonalizeRegistry -Key $systemThemeKeyName -Value (themeToRegistryValue $value)
}

Function Get-WindowsTheme {
    [PSCustomObject]@{
        apps = Get-WindowsAppsTheme
        system = Get-WindowsSystemTheme
    }
}

Function Set-WindowsTheme {
    Param (
        [ValidateSet( 'light', 'dark' )]
        [string] $Apps = $lightTheme,
        [ValidateSet( 'light', 'dark' )]
        [string] $System = $darkTheme
    )

    # apps theme param
    Set-WindowsAppsTheme $Apps

    # system theme param
    Set-WindowsSystemTheme $System
}

Function Use-WindowsDefaultTheme {
    Set-WindowsTheme
}

Function Use-WindowsInvertedTheme {
    Set-WindowsTheme -Apps $darkTheme -System $lightTheme
}

Function Use-WindowsLightTheme {
    Set-WindowsTheme -Apps $lightTheme -System $lightTheme
}

Function Use-WindowsDarkTheme {
    Set-WindowsTheme -Apps $darkTheme -System $darkTheme
}

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

# Export-ModuleMember @moduleMember