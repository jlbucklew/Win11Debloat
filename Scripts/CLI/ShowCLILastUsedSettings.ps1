# Shows the CLI last used settings from LastUsedSettings.json file, displays pending changes and prompts the user to apply them.
function ShowCLILastUsedSettings {
    PrintHeader 'Custom Mode'

    try {
        # Load settings from LastUsedSettings.json and add to params
        LoadSettings -filePath $script:SavedSettingsFilePath -expectedVersion "1.0"
    }
    catch {
        Write-Error "Failed to load settings from LastUsedSettings.json file: $_"
        AwaitKeyToExit
    }

    # Add default Apps parameter if RemoveApps was loaded from settings but Apps was not set.
    # The check in the main script runs before settings are loaded from file, so it must be repeated here.
    if ((-not $script:Params.ContainsKey("Apps")) -and $script:Params.ContainsKey("RemoveApps")) {
        $script:Params.Add('Apps', 'Default')
    }

    PrintPendingChanges
    PrintHeader 'Custom Mode'
}