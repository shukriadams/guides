# Powershell Guidelines

## Error handling

Powershell scripts will continue running if you call a sub function or script and these fail. You can set the main script to automatically abort itself on all errors with the following, which should be set as close to the start of any Powershell script.

    $ErrorActionPreference = "Stop"

If you call one Powershell script from another, and the called script returns an error code, the callee will not fail automatically, even if `ErrorActionPreference` is set. In these cases you should always explicitly check and handle errors

    & "./myScript.ps1"
    if ($LastExitCode -ne 0){
        Write-Host "myScript.ps1 exited with $($LastExitCode)"
        exit $LastExitCode
    } 
    
## String Concatenation

The safest way to concatenate strings is 

    "some text $($some-variable) some other text"
    
This is preferred over 

    "some text" + $some-variable + "some other text"

as it is easier to read.
    
