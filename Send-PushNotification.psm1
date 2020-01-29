<#
.Synopsis
   Use this custom function to send Push Notifications with the help of the Microsoft Visual Studio App Center REST API.
.EXAMPLE
   Send-PushNotification -Title "This is the title> -Body "Enter some text here"
   #>
function Send-PushNotification
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter(Mandatory = $True,
        ValueFromPipeline = $False,
        Position=0,
        HelpMessage = "Enter desired title")]
        [string[]]$Title,

        [Parameter(Mandatory = $True,
        ValueFromPipeline = $False,
        Position=1,
        HelpMessage = "Enter body text")]
        [string[]]$Body


    )

    Begin
    {}

    Process
    {

       try {

        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
        $headers.Add("Content-Type", "application/json")
        $headers.Add("X-API-Token", "<ENTER-YOUR-API-TOKEN-HERE>")

$json = @"
            {
            "notification_content": {
            "name": "PushFromPowerShell",
            "title": "$Title",
            "body": "$Body",
            "custom_data": {"sound": "default"}
            },
            "notification_target": null
            }
"@

$response = Invoke-RestMethod 'https://appcenter.ms/api/v0.1/apps/<Username>/<AppName>/push/notifications' -Method 'POST' -Headers $headers -Body ([System.Text.Encoding]::UTF8.GetBytes($json))


            }


       catch {

        Write-Host $_ -ForegroundColor Red }

    }

    End
    {}

}