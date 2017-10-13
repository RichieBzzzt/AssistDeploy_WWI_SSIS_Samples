param (
    $InstanceUnderUse,
    [switch]$build,
    [switch]$deploy
)
Function Invoke-SSISBoD {
    Import-Module  ".\SSISBoD" -Force
    $WWI_SSIS = Join-Path (Split-Path -Path $PSScriptRoot -Parent) "\WWI_SSIS"
    $WWI_SSIS_SLN = Join-Path (Split-Path -Path $PSScriptRoot -Parent) "Assist_Deploy_WWI_SSIS_Samples.sln"
    $WWI_SSIS_PROJ = Join-Path $WWI_SSIS "WWI_SSIS.dtproj"
    $WWI_SSIS_JSON = Join-Path $WWI_SSIS "WWI_SSIS_ETL.json"
    $WWI_SSIS_ISPAC = Join-Path $WWI_SSIS "bin\development\WWI_SSIS.ispac"
    if ($build) {
        $devenv = 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.com'
        [boolean]$what = Test-VisualStudio2017Installed -vspath $devenv 
        if ($what -eq $true) {
            Write-Host "As Visual Studio 2017 is installed, we can build dtproj file." -ForegroundColor DarkMagenta
            Write-Host "If you want to open the project, you need to have at least SSDT 15.1 installed." -ForegroundColor Black -BackgroundColor Yellow
            Invoke-SsisBuild -vspath $devenv -ssis_proj $wwi_ssis_proj -ssis_sln $WWI_SSIS_SLN -config "Development"
        }
    }
    else{
        Write-Host "SSIS build skipped. Add build switch to run build." -ForegroundColor Black -BackgroundColor Red
    }
    if ($deploy) {
        Install-AssistDeploy -WorkingFolder $PSScriptRoot -NugetPath $PSScriptRoot 
        Import-Module "$PSScriptRoot\AssistDeploy" -Force
        Invoke-AssistDeploy -json_file $WWI_SSIS_JSON -ispac_file $WWI_SSIS_ISPAC -connection_string $InstanceUnderUse
    }
    else{
        Write-Host "SSIS deploy skipped. Add deploy switch to run build." -ForegroundColor Black -BackgroundColor Red
    }
}
Invoke-SSISBoD

