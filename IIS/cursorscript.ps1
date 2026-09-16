#Josh Nguyen (jqn4308@g.rit.edu) 9/11/2026

$activeUser = (Get-CimInstance Win32_ComputerSystem).UserName

if ($activeUser) {
    # Inline block that updates the cursor inside the interactive session
    $ScriptBlock = {
        $Sign = @'
[DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
public static extern bool SystemParametersInfo(int uiAction, int uiParam, string pvParam, int fWinIni);
'@
        $SPI_SETCURSORS = 0x0057
        $SPIF_UPDATEINIFILE = 0x01
        $SPIF_SENDCHANGE = 0x02
        
        $Type = Add-Type -MemberDefinition $Sign -Name "Win32SystemParametersInfo" -Namespace "Win32" -PassThru
        $Type::SystemParametersInfo($SPI_SETCURSORS, 0, $null, ($SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE))
    }

    # Execute the cursor refresh directly inside the active interactive user's environment
    $Principal = New-ScheduledTaskPrincipal -UserId $activeUser -LogonType Interactive
    $Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -WindowStyle Hidden -Command & {$ScriptBlock}"
    $Settings = New-ScheduledTaskSettingsSet -DeleteExpiredTaskAfter 00:00:05
    
    $TaskName = "AnsibleRefreshCursor"
    $Task = New-ScheduledTask -Action $Action -Principal $Principal -Settings $Settings
    
    # Register and trigger the task immediately, then clean it up
    Register-ScheduledTask -TaskName $TaskName -InputObject $Task | Out-Null
    Start-ScheduledTask -TaskName $TaskName
    Start-Sleep -Seconds 2
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
}