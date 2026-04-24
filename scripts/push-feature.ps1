<#
Simple interactive helper to create a feature branch, commit staged/unstaged changes and push to origin.

Usage examples:
  # Interactive prompts
  .\scripts\push-feature.ps1

  # Provide branch and message non-interactively
  .\scripts\push-feature.ps1 -BranchName "feature/add-readme-2833" -Message "Add README for problem 2833"

The script will:
  - verify it's in a git repository
  - optionally create a feature branch (feature/<name>)
  - stage all changes (or skip if you choose)
  - create a commit with a message you provide
  - push the branch to origin

The script asks for confirmation before performing each major step.
#>

param(
    [string]$BranchName,
    [string]$Message
)

Set-StrictMode -Version Latest

function Abort($msg) {
    Write-Host "ERROR: $msg" -ForegroundColor Red
    exit 1
}

# Ensure we are in a git repo
if (-not (git rev-parse --is-inside-work-tree 2>$null)) {
    Abort "This directory is not a git repository. Run this script from the repository root."
}

# --- NEW: refresh remote refs to reduce push surprises ---
Write-Host "Fetching remote refs (git fetch origin --prune)..."
if (-not (git fetch origin --prune 2>$null)) {
    Write-Host "Warning: git fetch returned a non-zero exit code (network or remote issue). You can still continue, but remote info may be stale." -ForegroundColor Yellow
}
# ------------------------------------------------------

# Get current branch
$currentBranch = (git rev-parse --abbrev-ref HEAD).Trim()
Write-Host "Current branch: $currentBranch"

# Determine branch name
if (-not $BranchName -or [string]::IsNullOrWhiteSpace($BranchName)) {
    $short = Read-Host "Enter a short name for the feature branch (e.g. add-readme-2833)"
    if ([string]::IsNullOrWhiteSpace($short)) { Abort "Branch name is required." }
    $BranchName = "feature/$short"
} else {
    # normalize if user passed a name without prefix
    if ($BranchName -notmatch '^feature/') {
        $BranchName = "feature/$BranchName"
    }
}

Write-Host "Target branch: $BranchName"

# Check if branch exists locally
$existsLocal = git show-ref --verify --quiet "refs/heads/$BranchName"; $localExists = ($LASTEXITCODE -eq 0)
# Check remote (after fetch we just ran)
git ls-remote --exit-code --heads origin $BranchName >$null 2>&1; $remoteExists = ($LASTEXITCODE -eq 0)

if ($localExists) { Write-Host "Branch already exists locally." -ForegroundColor Yellow }
if ($remoteExists) { Write-Host "Branch already exists on origin." -ForegroundColor Yellow }

# Create/switch to branch if needed
if ($currentBranch -ne $BranchName) {
    $createConfirm = Read-Host "Switch to '$BranchName'? (y/n)"
    if ($createConfirm -ne 'y') { Write-Host "Aborting branch switch."; exit 0 }

    if (-not $localExists) {
        Write-Host "Creating and switching to local branch $BranchName..."
        git checkout -b $BranchName || Abort "Failed to create branch $BranchName"
    } else {
        Write-Host "Switching to existing local branch $BranchName..."
        git checkout $BranchName || Abort "Failed to switch to branch $BranchName"
    }
}

# --- NEW: re-evaluate remote branch existence and offer to update local branch ---
# Re-check remote branch now that we've fetched earlier
git ls-remote --exit-code --heads origin $BranchName >$null 2>&1; $remoteExistsNow = ($LASTEXITCODE -eq 0)
if ($remoteExistsNow) {
    $pullConfirm = Read-Host "Remote branch origin/$BranchName exists. Would you like to run 'git pull --rebase --autostash' to update your local branch before pushing? (y/n)"
    if ($pullConfirm -eq 'y') {
        Write-Host "Running git pull --rebase --autostash..."
        if (-not (git pull --rebase --autostash)) {
            Write-Host "Warning: git pull --rebase --autostash failed or returned non-zero exit code. Please resolve any conflicts manually before pushing." -ForegroundColor Yellow
        } else {
            Write-Host "Branch updated from origin." -ForegroundColor Green
        }
    } else {
        Write-Host "Skipping pull/rebase as requested." -ForegroundColor Yellow
    }
}
# ------------------------------------------------------

# Stage changes
Write-Host "Git status:"; git status --short
$stageConfirm = Read-Host "Stage all changes (git add -A)? (y/n)"
if ($stageConfirm -eq 'y') {
    git add -A || Abort "git add failed"
    Write-Host "All changes staged." -ForegroundColor Green
} else {
    Write-Host "Skipping staging. Make sure you staged the files you want to commit." -ForegroundColor Yellow
}

# Commit
if (-not $Message -or [string]::IsNullOrWhiteSpace($Message)) {
    $Message = Read-Host "Enter commit message (or leave empty to skip committing)"
}

if (-not [string]::IsNullOrWhiteSpace($Message)) {
    $commitConfirm = Read-Host "Create commit with message: '$Message'? (y/n)"
    if ($commitConfirm -eq 'y') {
        git commit -m "$Message" || Abort "git commit failed (maybe nothing to commit)"
        Write-Host "Committed." -ForegroundColor Green
    } else { Write-Host "Skipping commit." }
} else {
    Write-Host "No commit message provided; skipping commit." -ForegroundColor Yellow
}

# Push
$pushConfirm = Read-Host "Push branch '$BranchName' to origin? (y/n)"
if ($pushConfirm -eq 'y') {
    git push -u origin $BranchName || Abort "git push failed"
    Write-Host "Pushed branch to origin/$BranchName" -ForegroundColor Green
} else {
    Write-Host "Skipping push." -ForegroundColor Yellow
}

Write-Host "Done." -ForegroundColor Cyan
