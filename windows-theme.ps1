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
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    Param (
        [string] $Key,
        $Value
    )

    if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        New-ItemProperty -Path $keyPath -Name $Key -Value $Value -Type Dword -Force | out-null
    } else {
        throw "Can't apply necessary registry edit to change de theme"
    }
}

Function Get-WindowsAppsTheme {
    return (registryValueToTheme (Get-PersonalizeRegistry $appsThemeKeyName))
}

Function Set-WindowsAppsTheme {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    Param (
        [ValidateSet( 'light', 'dark' )]
        [string] $value
    )

    if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        Set-PersonalizeRegistry -Key $appsThemeKeyName -Value (themeToRegistryValue $value)
    } else {
        throw "Error. Impossible to apply the theme modification due to lack of permission"
    }
}

Function Get-WindowsSystemTheme {
    return (registryValueToTheme (Get-PersonalizeRegistry $systemThemeKeyName))
}

Function Set-WindowsSystemTheme {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    Param (
        [ValidateSet( 'light', 'dark' )]
        [string] $value
    )

    if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        Set-PersonalizeRegistry -Key $systemThemeKeyName -Value (themeToRegistryValue $value)
    } else {
        throw "Error. Impossible to apply the theme modification due to lack of permission"
    }
}

Function Get-WindowsTheme {
    [PSCustomObject]@{
        apps = Get-WindowsAppsTheme
        system = Get-WindowsSystemTheme
    }
}

Function Set-WindowsTheme {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    Param (
        [ValidateSet( 'light', 'dark' )]
        [string] $Apps = $lightTheme,
        [ValidateSet( 'light', 'dark' )]
        [string] $System = $darkTheme
    )

    if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        # apps theme param
        Set-WindowsAppsTheme $Apps

        # system theme param
        Set-WindowsSystemTheme $System
    } else {
        throw "Error. Impossible to apply the theme modification due to lack of permission"
    }
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