$InvokeSSISBoD = Join-Path $PSScriptRoot "\SSISBoD\InvokeSSISBoD.ps1"
. $InvokeSSISBoD -InstanceUnderUse $svrConnstring -Deploy -LocalModulePath "C:\Users\Richie\Source\Repos\AssistDeploy" -rollback -SimulateFailedDeployment