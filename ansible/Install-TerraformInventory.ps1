# Define URLs for executable download
if($PSVersiontable.Platform -match "Unix") { # Unix system
    $url = "https://github.com/adammck/terraform-inventory/releases/download/v0.9/terraform-inventory_0.9_linux_amd64.zip"
} elseif($PSVersiontable.Platform -match "Win") { # Windows system
    $url = "https://github.com/adammck/terraform-inventory/releases/download/v0.9/terraform-inventory_0.9_windows_amd64.zip"
} else {
    Write-Error "Platform version not set up."
}

# Download executable zip
Invoke-WebRequest -URI $url -OutFile "ti.zip"

# Extract file
Expand-Archive ti.zip

# Move executable outside of directory
Move-Item ti/terraform-inventory -Destination ./

# Delete zip and folder
Remove-Item ti,ti.zip