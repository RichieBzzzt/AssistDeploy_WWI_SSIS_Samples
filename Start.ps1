Clear-Host
#build and deploy databases
$svrConnstring = "SERVER=.;Integrated Security=True;Database=master"
$InvokeSSDTBoD = Join-Path $PSScriptRoot "\SSDTBoD\InvokeSSDTBoD.ps1"
. $InvokeSSDTBoD -InstanceUnderUse $svrConnstring -Build -Deploy
#build and deploy ssis packages
$InvokeSSISBoD = Join-Path $PSScriptRoot "\SSISBoD\InvokeSSISBoD.ps1"
. $InvokeSSISBoD -InstanceUnderUse $svrConnstring -Build -Deploy
#Deploy SQL Agent Job
$InvokesaltD = Join-Path $PSScriptRoot "\saltD\InvokesaltD.ps1"
. $InvokesaltD -InstanceUnderUse $svrConnstring -MachineOrDomainName $env:computername -userName $env:UserName -SQLAgentServerName $env:computername -IntegrationServicesCatalogServer $env:computername -LocalModulePath "C:\Users\SQLTraining\source\repos\salt\salt"