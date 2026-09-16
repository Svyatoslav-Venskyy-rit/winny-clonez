# Svyatoslav Venskyy, ssv5593@rit.edu, 9/11/2026
# Galactic Republic Notification GPO


# imports the modules needed
Import-Module GroupPolicy
Import-Module ActiveDirectory

#setup names and paths
$GPOName  = "Galactic Republic Notification"
$TaskName = "Galactic Republic Notification"
$ScriptPath = "C:\Program Files\Galactic_Republic\notifications.ps1"
$WorkingDir = "C:\Program Files\Galactic_Republic"

# Getting Domain information
$Domain = Get-ADDomain
$DomainDNS = $Domain.DNSRoot
$DomainDN  = $Domain.DistinguishedName
Write-Host "Domain: $DomainDNS"
Write-Host "Domain DN: $DomainDN"

#see if gpo already exists
$GPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue

# making GPO if does not already exists
if ($null -eq $GPO) {
    Write-Host "Creating GPO: $GPOName"
    $GPO = New-GPO `
        -Name $GPOName `
        -Comment "Runs the Galactic Republic notification every 2 minutes for logged-in domain users."
}
# OBviously doesnt make the GPO
else {
    Write-Host "GPO already exists: $GPOName"
}

# This ties/links the GPO to the domain
$Inheritance = Get-GPInheritance -Target $DomainDN
$ExistingLink = $Inheritance.GpoLinks |
    Where-Object { $_.DisplayName -eq $GPOName }

#if from above the GPO is not liked then it will link it
if ($null -eq $ExistingLink) {
    Write-Host "Linking GPO to domain: $DomainDN"
    New-GPLink `
        -Name $GPOName `
        -Target $DomainDN `
        -LinkEnabled Yes | Out-Null
}
# OBviously not linking the GPO to the domain
else {
    Write-Host "GPO is already linked to the domain."
}

# Location of the GPO being set and other variables set
$GPOGuid = $GPO.Id.ToString("B").ToUpper()
$GPOPath = "\\$DomainDNS\SYSVOL\$DomainDNS\Policies\$GPOGuid"
$ScheduledTaskPath =
    Join-Path $GPOPath "User\Preferences\ScheduledTasks"
$ScheduledTaskFile =
    Join-Path $ScheduledTaskPath "ScheduledTasks.xml"

# create scheduled task path if not already made
if (!(Test-Path $ScheduledTaskPath)) {

    New-Item `
        -ItemType Directory `
        -Path $ScheduledTaskPath `
        -Force | Out-Null
}


$TaskUID = "{6F35C297-AB37-4827-9285-AD347A694216}"
# Task GPP XML
$ScheduledTaskXML = @"
<?xml version="1.0" encoding="utf-8"?>
<ScheduledTasks clsid="{CC63F200-7309-4ba0-B154-A71CD118DBCC}">
  <TaskV2
    clsid="{D8896631-B747-47a7-84A6-C155337F3BC8}"
    name="$TaskName"
    image="2"
    changed="2026-09-10 21:00:00"
    uid="$TaskUID"
    userContext="0"
    removePolicy="0">

    <!-- This section creates the task for the user that is logged in -->
    <Properties
      action="U"
      name="$TaskName"
      runAs="%LogonDomain%\%LogonUser%"
      logonType="InteractiveToken">

      <Task version="1.2">

        <!-- basic information from theme -->
        <RegistrationInfo>
          <Author>Galactic Republic</Author>
          <Description>
            Displays the Galactic Republic notification every 2 minutes.
          </Description>
        </RegistrationInfo>

        <!-- running as the logged in account but without the admin privileges -->
        <Principals>
          <Principal id="Author">
            <UserId>%LogonDomain%\%LogonUser%</UserId>
            <LogonType>InteractiveToken</LogonType>
            <RunLevel>LeastPrivilege</RunLevel>
          </Principal>
        </Principals>

        <!-- The General scheduled task settings -->
        <Settings>
          <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
          <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
          <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
          <AllowHardTerminate>true</AllowHardTerminate>
          <StartWhenAvailable>true</StartWhenAvailable>
          <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
          <AllowStartOnDemand>true</AllowStartOnDemand>
          <Enabled>true</Enabled>
          <Hidden>false</Hidden>
          <RunOnlyIfIdle>false</RunOnlyIfIdle>
          <WakeToRun>false</WakeToRun>
          <ExecutionTimeLimit>PT5M</ExecutionTimeLimit>
          <Priority>7</Priority>
        </Settings>

        <!-- trigger is set for the task to loop again every 2 mins(pt2m) -->
        <Triggers>

          <RegistrationTrigger>
            <Enabled>true</Enabled>

            <Repetition>
              <Interval>PT2M</Interval>
              <StopAtDurationEnd>false</StopAtDurationEnd>
            </Repetition>

          </RegistrationTrigger>

        </Triggers>

        <!-- Runs the notifications.ps1 PowerSHell script -->
        <Actions Context="Author">

          <Exec>

            <Command>C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe</Command>

            <Arguments>-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "$ScriptPath"</Arguments>

            <WorkingDirectory>$WorkingDir</WorkingDirectory>

          </Exec>

        </Actions>

      </Task>

    </Properties>

  </TaskV2>
</ScheduledTasks>
"@

# sees if the XML is scheduled or not
if (Test-Path $ScheduledTaskFile) {
    $ExistingXML = Get-Content `
        -Path $ScheduledTaskFile `
        -Raw
    if ($ExistingXML.Trim() -eq $ScheduledTaskXML.Trim()) {
        $XMLChanged = $false
        Write-Host "Scheduled Task configuration already matches."
    }
}

# writing the xml file with contents from above
if ($XMLChanged) {
    Write-Host "Writing Scheduled Task preference..."
    $UTF8NoBOM =
        New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText(
        $ScheduledTaskFile,
        $ScheduledTaskXML,
        $UTF8NoBOM
    )

    # {AADCED64-746C-4633-A97C-D61349046527} is a scheduled task client side extension
    # {CAB54552-DEEA-4691-817E-ED4A4D1AFC72} another extension that is needed for the scheduled task
    $ScheduledTasksExtension = "[{AADCED64-746C-4633-A97C-D61349046527}{CAB54552-DEEA-4691-817E-ED4A4D1AFC72}]"

    $GPOADPath = "CN=$GPOGuid,CN=Policies,CN=System,$DomainDN"
    $GPOAD = Get-ADObject `
        -Identity $GPOADPath `
        -Properties versionNumber,gPCUserExtensionNames

    # this preserves a previous GPOs if there were any, otherwise adds the extensions for this scheduled task
    $CurrentExtensions = [string]$GPOAD.gPCUserExtensionNames

    if ([string]::IsNullOrWhiteSpace($CurrentExtensions)) {
        $NewExtensions =
            $ScheduledTasksExtension
    }
    elseif (
        $CurrentExtensions -notmatch
        "AADCED64-746C-4633-A97C-D61349046527"
    ) {
        $NewExtensions =
            $CurrentExtensions + $ScheduledTasksExtension
    }
    else {
        $NewExtensions =
            $CurrentExtensions
    }

    # version of the GPOs
    $CurrentVersion = [uint32]$GPOAD.versionNumber
    $UserVersion = ($CurrentVersion -shr 16) -band 0xFFFF
    $ComputerVersion = $CurrentVersion -band 0xFFFF
    #adding to the user version
    $UserVersion++
    $NewVersion =
        ($UserVersion -shl 16) -bor $ComputerVersion

    #updates GPO object
    $GPOADSI = [ADSI]"LDAP://$GPOADPath"
    $GPOADSI.Put(
        "versionNumber",
        [int]$NewVersion
    )
    $GPOADSI.Put(
        "gPCUserExtensionNames",
        $NewExtensions
    )
    $GPOADSI.SetInfo()


    #lmao the name
    # no seriously this is the group policy objects meta data and version #
    $GPTIniPath = Join-Path $GPOPath "GPT.ini"
    if (Test-Path $GPTIniPath) {
        $GPTContent =
            Get-Content $GPTIniPath -Raw
    }
    else {
        $GPTContent =
            "[General]`r`n"
    }

    if ($GPTContent -match '(?im)^Version=\d+') {
        $GPTContent =
            $GPTContent -replace `
                '(?im)^Version=\d+',
                "Version=$NewVersion"
    }
    else {
        $GPTContent +=
            "`r`nVersion=$NewVersion`r`n"
    }
    [System.IO.File]::WriteAllText(
        $GPTIniPath,
        $GPTContent,
        [System.Text.Encoding]::ASCII
    )
    Write-Host "GPO version updated to: $NewVersion"
}

#this took way too damn long...