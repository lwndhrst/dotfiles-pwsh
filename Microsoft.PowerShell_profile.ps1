function Write-GitBranchName {
    $branch = $(git rev-parse --abbrev-ref HEAD)

    if ($branch) {
        Write-Host " git:(" -NoNewline -ForegroundColor green
        Write-Host $branch -NoNewline -ForegroundColor red
        Write-Host ")" -NoNewline -ForegroundColor green
    }
}

function prompt {
    Write-Host "$(Convert-Path $(Get-Location))" -NoNewline -ForegroundColor blue

    Write-GitBranchName

    Write-Host ""
    Write-Host "→" -NoNewline -ForegroundColor green
    return " "
}
