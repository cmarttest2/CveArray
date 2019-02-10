### Build script called by Azure Pipelines
Write-Host "I'm the build script"

# Install Pester module if it is not already installed
if (-not (Get-Module -Name Pester -ListAvailable))
{
    Write-Host "Installing Pester"
    Install-Module -Name Pester -Scope CurrentUser -Force -Confirm:$false
}

### Find out what version of Pester we have
Get-Module Pester -ListAvailable

function Add-Numbers($a, $b) {
    
    return $a + $b
}

$TestResults = Invoke-Pester -Script .\tests -PassThru

#$TestResults
#Write-Host "$("##vso[task.LogIssue type=error;]") $("the task.LogIssue Azure Pipelines logging command reported that") $('foo')"
#Write-Host "$("##vso[task.setvariable variable=ErrorMessage]") $('foo')"
$testResults.TestResult | Where Result -EQ Failed

<#
if($TestResults.FailedCount -gt 0)
{
    Write-Error -Message ($testResults.TestResult | Where Result -EQ Failed)
    #exit 1
}
#>
