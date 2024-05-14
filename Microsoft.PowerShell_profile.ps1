Set-PSReadLineOption -Colors @{ InlinePrediction = "DarkGray" }
Set-PSReadlineKeyHandler -Key "ctrl+e" -Function AcceptSuggestion

function Write-CurrentWorkingDirectory {
    Write-Host $(Convert-Path $(Get-Location)) -NoNewline -ForegroundColor Cyan
}

function Write-GitBranch {
    $branch = $(git rev-parse --abbrev-ref HEAD)

    if ($branch) {
        Write-Host " git:(" -NoNewline -ForegroundColor Blue
        Write-Host $branch -NoNewline -ForegroundColor Red
        Write-Host ")" -NoNewline -ForegroundColor Blue
    }
}

function Write-PromptSymbol {
    Write-Host "→" -NoNewline -ForegroundColor Green
}

function Write-NewLine {
    Write-Host ""
}

function Prompt {
    Write-CurrentWorkingDirectory
    Write-GitBranch
    Write-NewLine

    Write-PromptSymbol

    return " "
}
