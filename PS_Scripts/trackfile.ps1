function Get-ZID ($zid) {
    switch ($zid) {
    0	{"My Computer";break;}
    1	{"Local Intranet";break;}
    2	{"Trusted Sites";break;}
    3	{"Internet";break;}
    4	{"Restricted Sites";break;} 
    default {"Unknown";break;}
    }
}

function Get-FileZoneID ($path) {
if (Test-Path $path) {
$ZI = try {Get-Content $path -Stream Zone.Identifier -ErrorAction stop} catch {$message = $error[0].Exception.Message; $err=$true}
if ($err) {
    $prop = @{
    FilePath = $path
    Test = "File Present. Error returned"
    ZoneID = $message
    Zone = $null
    ReferrerURL = $null
    HostURL = $null
    FileVersion = (Get-Item $path).VersionInfo.FileVersion
    ProductVersion = (Get-Item $path).VersionInfo.ProductVersion
    }

} else {
$prop = @{
    FilePath = $path
    Test = "File Present"
    ZoneID = $zi[1].split('=')[1]
    Zone = Get-ZID $zi[1].split('=')[1]
    ReferrerURL = $zi[2].split('=')[1]
    HostURL = $zi[3].split('=')[1]
    FileVersion = (Get-Item $path).VersionInfo.FileVersion
    ProductVersion = (Get-Item $path).VersionInfo.ProductVersion
    }

} 

} else {
$prop = @{
    FilePath = $path
    Test = "File Missing"
    ZoneID = "N/A"
    Zone = "N/A"
    ReferrerURL = "N/A"
    HostURL = "N/A"
    FileVersion = "N/A"
    ProductVersion = "N/A"
    }

}

$obj = New-Object -TypeName psobject -Property $prop
$obj
}






