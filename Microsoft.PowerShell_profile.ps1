Set-PSReadLineOption -Colors @{ InlinePrediction = "DarkGray" }
Set-PSReadlineKeyHandler -Key "ctrl+e" -Function AcceptSuggestion

function Write-CurrentWorkingDirectory {
    Write-Host "$(Convert-Path $(Get-Location)) " -NoNewline -ForegroundColor Cyan
}

function Write-GitBranch {
    $branch = $(git rev-parse --abbrev-ref HEAD)

    if ($branch) {
        Write-Host "on " -NoNewline -ForegroundColor White
        Write-Host " $branch " -NoNewline -ForegroundColor Magenta
    }
}

function Write-GitStatus {
    $status = $(git status --porcelain)

    $changes = @()

    foreach ($line in $status) {
        $change = $line.trimStart().split(' ')[0]
        if (!$changes.Contains($change)) {
            $changes += $change
        }
    }

    if ($changes.count -gt 0) {
        Write-Host "[" -NoNewline -ForegroundColor Red

        # `=` – This branch has merge conflicts
        # `⇡` – This branch is ahead of the branch being tracked
        # `⇣` – This branch is behind of the branch being tracked
        # `⇕` – This branch has diverged from the branch being tracked
        # `` – This branch is up-to-date with the branch being tracked
        # `?` — There are untracked files in the working directory
        # `$` — A stash exists for the local repository
        # `!` — There are file modifications in the working directory
        # `+` — A new file has been added to the staging area
        # `»` — A renamed file has been added to the staging area
        # `✘` — A file's deletion has been added to the staging area
        switch ($changes) {
            '##' { Write-Host "⇡" -NoNewline -ForegroundColor Red }
            '??' { Write-Host "?" -NoNewline -ForegroundColor Red }
            'M'  { Write-Host "!" -NoNewline -ForegroundColor Red }
            'A'  { Write-Host "+" -NoNewline -ForegroundColor Red }
            'R'  { Write-Host "»" -NoNewline -ForegroundColor Red }
            'D'  { Write-Host "✘" -NoNewline -ForegroundColor Red }
        }

        Write-Host "] " -NoNewline -ForegroundColor Red
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
    Write-GitStatus

    Write-NewLine
    Write-PromptSymbol

    return " "
}
