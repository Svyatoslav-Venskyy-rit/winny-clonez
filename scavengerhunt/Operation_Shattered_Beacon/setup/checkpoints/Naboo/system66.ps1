[CmdletBinding()]
param(
    [string]$HuntReader,
    [string]$DnsServer,
    [ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars',
    [string]$RookAccount,
    [switch]$AllowDifferentComputerName
)
$ExpectedHost = 'Naboo'
. (Join-Path $PSScriptRoot '..\..\Common.ps1')
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Circuit' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Circuit'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
@'
<?xml version="1.0" encoding="UTF-8"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo><Description>Republic relay circuit 66: identity evidence</Description></RegistrationInfo>
  <Triggers />
  <Principals>
    <Principal id="RelayPrincipal">
      <UserId>S-1-5-18</UserId>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings><Enabled>false</Enabled></Settings>
  <Actions Context="RelayPrincipal">
    <Exec><Command>cmd.exe</Command><Arguments>/c echo Relay identity fixture</Arguments></Exec>
  </Actions>
</Task>
'@ | Set-Content "$dir\controller.xml" -Encoding UTF8
