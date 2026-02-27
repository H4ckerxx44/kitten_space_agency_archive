$dirs = @(
	'2076', '2088', '2091', '2101', '2108', '2112', '2121', '2125', '2133', '2136', '2163', '2167', '2169', '2171',
	'2181', '2197', '2212', '2234', '2250', '2252', '2263', '2270', '2279', '2290', '2298', '2300', '2317', '2336',
	'2364', '2376', '2383', '2399', '2404', '2415', '2429', '2441', '2476', '2497', '2502', '2530', '2540', '2547',
	'2554', '2573', '2584', '2613', '2620', '2634', '2742', '2781', '2789', '2791', '2819', '2829', '2844', '2847',
	'2894', '2897', '2915', '2924', '2939', '2945', '2971', '2976', '2991', '2994', '3000', '3011', '3014', '3030',
	'3041', '3047', '3057', '3072', '3082', '3097', '3103', '3123', '3181', '3194', '3232', '3233', '3249', '3270',
	'3279', '3293', '3299', '3309', '3329', '3335', '3345', '3353', '3384', '3396', '3419', '3423', '3428', '3454',
	'3473', '3529', '3538', '3549', '3563', '3592', '3622', '3638', '3640', '3646', '3656', '3667', '3695', '3699',
    '3713')

foreach ($dir in $dirs)
{
	$path = "builds/$dir"
	if (-not (Test-Path $path))
	{
		New-Item  -ItemType "Directory"
	}
}

$targetRoot = "builds"

# Ensure target root exists
if (!(Test-Path $targetRoot)) {
    New-Item -ItemType Directory -Path $targetRoot | Out-Null
}

# Process both folders together
Get-ChildItem -Path @("exe", "versions") -File | ForEach-Object {
    if ($_.Name -match '\.(\d+)\.exe(\.torrent)?$') {
        $build = $matches[1]
        $targetDir = Join-Path $targetRoot $build

        if (!(Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir | Out-Null
        }

        Move-Item $_.FullName -Destination $targetDir
    }
}