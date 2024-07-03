Set-WinSystemLocale -SystemLocale zh-CN

<#
.SYNOPSIS
    Invokes a command and imports its environment variables.

.DESCRIPTION
    It invokes any cmd shell command (normally a configuration batch file) and
    imports its environment variables to the calling process. Command output is
    discarded completely. It fails if the command exit code is not 0. To ignore
    the exit code use the 'call' command.

.EXAMPLE
    # Invokes Config.bat in the current directory or the system path
    Invoke-Environment Config.bat

.EXAMPLE
    # Visual Studio environment: works even if exit code is not 0
    Invoke-Environment 'call "%VS100COMNTOOLS%\vsvars32.bat"'

.EXAMPLE
    # This command fails if vsvars32.bat exit code is not 0
    Invoke-Environment '"%VS100COMNTOOLS%\vsvars32.bat"'
#>
function Invoke-Env {
    param
    (
        # Any cmd shell command, normally a configuration batch file.
        [Parameter(Mandatory=$true)]
        [string] $Command
    )

    $Command = "`"" + $Command + "`""
    cmd /c "$Command > nul 2>&1 && set" | . { process {
        if ($_ -match '^([^=]+)=(.*)') {
            [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2])
        }
    }}

}

function SetVC64Env { 
	Invoke-Env "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat" 
}

Set-Alias -Name 7z -Value "c:\Program files\7-zip\7z.exe"
Set-Alias -Name which -Value "Get-Command"
Set-Alias -Name vc64 -Value SetVC64Env

Remove-Item Alias:rmdir 
function rmdir { Remove-Item -Recurse $args }
