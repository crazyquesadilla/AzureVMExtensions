# Source: https://docs.microsoft.com/en-us/azure/virtual-machines/windows/attach-disk-ps#initialize-the-disk

$disks = Get-Disk | Where partitionstyle -eq 'raw' | sort number

$letters = "X","Y"
$count = 0
$labels = "Data","Log"

foreach ($disk in $disks) {
    $driveLetter = $letters[$count]
    $disk | 
    Initialize-Disk -PartitionStyle MBR -PassThru |
    New-Partition -UseMaximumSize -DriveLetter $driveLetter |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel $labels[$count] -Confirm:$false -Force
    $count++
}
