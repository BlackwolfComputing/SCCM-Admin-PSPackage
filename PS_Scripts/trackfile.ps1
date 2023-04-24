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
$ZI = Get-Content $path -Stream Zone.Identifier

$prop = @{
    FilePath = $path
    Test = "File Present"
    ZoneID = $ZI.ZoneID
    Zone = Get-ZID $ZI.ZoneID
    ReferrerURL = $ZI.RefferrerUrl
    HostURL = $ZI.HostURL
    }
} else {
$prop = @{
    FilePath = $path
    Test = "File Missing"
    ZoneID = "N/A"
    Zone = "N/A"
    ReferrerURL = "N/A"
    HostURL = "N/A"
    }

}

$obj = New-Object -TypeName psobject -Property $prop
$obj
}
