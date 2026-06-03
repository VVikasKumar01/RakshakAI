$apiKey = $env:STITCH_API_KEY
if (-not $apiKey) {
    Write-Error "STITCH_API_KEY environment variable is not set. Please set it before running this script."
    Exit 1
}
$projectId = $env:STITCH_PROJECT_ID
if (-not $projectId) {
    $projectId = "13300471906329805729"
}
$baseUrl = "https://stitch.googleapis.com/v1/projects/$projectId/screens"
$outDir = "d:\VIKAS\Hackathon\RakshakAI"

$screens = @(
    @{ id = "fe2dd36109654d238effec5aff6c238a"; name = "login" },
    @{ id = "89abcd54356f48c2b2c3f986c977b2bf"; name = "home" },
    @{ id = "7b24fd16d8c6457b85980b3e461a051b"; name = "dashboard" },
    @{ id = "09fd33fb8eec45a48bd63b75c1a75bac"; name = "regulations" },
    @{ id = "112552f7257849bab68c25e39b4f2702"; name = "kanban" },
    @{ id = "acbb998dcc274a849b8dff1cc41c9e3a"; name = "audit_log" }
)

foreach ($screen in $screens) {
    $screenId = $screen.id
    $screenName = $screen.name
    $metaFile = "$outDir\screen_$screenName.json"

    Write-Host "=== Fetching metadata: $screenName ===" -ForegroundColor Cyan
    curl.exe -s -L -H "X-Goog-Api-Key: $apiKey" "$baseUrl/$screenId" -o $metaFile
    Write-Host "Saved: $metaFile"

    $meta = Get-Content $metaFile -Raw | ConvertFrom-Json

    # Download screenshot image
    $imgUrl = $meta.screenshot.downloadUrl
    if ($imgUrl) {
        Write-Host "Downloading screenshot for $screenName..."
        curl.exe -s -L "$imgUrl" -o "$outDir\img_$screenName.png"
        Write-Host "Saved: img_$screenName.png"
    } else {
        Write-Host "No screenshot URL for $screenName" -ForegroundColor Yellow
    }

    # Download HTML code
    $htmlUrl = $meta.htmlCode.downloadUrl
    if ($htmlUrl) {
        Write-Host "Downloading HTML for $screenName..."
        curl.exe -s -L "$htmlUrl" -o "$outDir\code_$screenName.html"
        Write-Host "Saved: code_$screenName.html"
    } else {
        Write-Host "No HTML URL for $screenName" -ForegroundColor Yellow
    }

    Write-Host ""
}

Write-Host "=== All screens done ===" -ForegroundColor Green
