#!/bin/bash

# Input: base branch to compare against
BASE_BRANCH=$1

# Ensure the base branch is fetched
git fetch origin "$BASE_BRANCH:$BASE_BRANCH"

# List changed files between the base branch and current commit
CHANGED_FILES=$(git diff --name-only "$BASE_BRANCH" "$GITHUB_SHA")

# Check if there are any changed files
if [ -z "$CHANGED_FILES" ]; then
  echo "No files changed between $BASE_BRANCH and $GITHUB_REF_NAME"
  CHANGED_FILES="None"
else
  echo "Files changed between $BASE_BRANCH and $GITHUB_REF_NAME:"
  echo "$CHANGED_FILES"
fi

# Set the output with proper multi-line handling
{
  echo "changed-files<<EOF"
  echo "$CHANGED_FILES"
  echo "EOF"
} >> "$GITHUB_OUTPUT"

