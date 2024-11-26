#!/bin/bash

# Check and install GitHub CLI (gh)
echo "Checking if GitHub CLI (gh) is installed..."
if ! command -v gh &>/dev/null; then
    echo "GitHub CLI is not installed. Installing it now..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # For Linux
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update
        sudo apt install gh -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # For macOS
        if ! command -v brew &>/dev/null; then
            echo "Homebrew is required to install GitHub CLI. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install gh
    else
        echo "Unsupported OS. Please install GitHub CLI manually from https://cli.github.com/"
        exit 1
    fi
else
    echo "GitHub CLI is already installed."
fi

# Prompt for GitHub username
read -p "Enter your GitHub username: " username

# Prompt for Personal Access Token (PAT)
read -s -p "Enter your GitHub Personal Access Token (PAT): " token
echo

# Log in to GitHub CLI
echo "Logging in to GitHub CLI with provided credentials..."
echo $token | gh auth login --with-token
if [ $? -eq 0 ]; then
    echo "Successfully logged in to GitHub using GitHub CLI."
else
    echo "GitHub CLI login failed. Please check your credentials."
    exit 1
fi

# Configure Git credentials
echo "Setting up Git credentials..."
git config --global credential.helper store

# Create a credentials file
echo "https://${username}:${token}@github.com" > ~/.git-credentials

# Verify Git configuration
if git config --list | grep "credential.helper"; then
    echo "Git credentials stored successfully."
else
    echo "Failed to configure Git credentials."
    exit 1
fi

# Verify GitHub CLI login
echo "Testing GitHub CLI login..."
gh auth status
if [ $? -eq 0 ]; then
    echo "GitHub CLI is correctly authenticated."
else
    echo "GitHub CLI authentication test failed."
    exit 1
fi

echo "GitHub CLI and Git credentials are successfully set up!"

