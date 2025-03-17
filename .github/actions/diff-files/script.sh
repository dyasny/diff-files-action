#!/bin/bash

# Input: base branch to compare against
BASE_BRANCH=$1

# Ensure the base branch is fetched
git fetch origin "$BASE_BRANCH:$BASE_BRANCH" > /dev/null 2>&1

# List changed files between the base branch and current commit
CHANGED_FILES=$(git diff --name-only "$BASE_BRANCH" "$GITHUB_SHA")

# Check if there are any changed files
if [ -z "$CHANGED_FILES" ]; then
  CHANGED_FILES="None"
fi

# Print to console for visibility (avoid redirecting to $GITHUB_OUTPUT here)
echo "Files changed between $BASE_BRANCH and $GITHUB_REF_NAME:"
echo "$CHANGED_FILES"

# Set the output with proper multi-line handling, ensuring no extra output
{
  echo "changed-files<<EOF"
  echo "$CHANGED_FILES"
  echo "EOF"
} >> "$GITHUB_OUTPUT"

