#!/bin/bash

# Function to display an error message and exit
function error_exit {
    echo "Error: $1"
    exit 1
}

# Function to prompt the user for a directory path
function prompt_for_directory {
    read -p "Enter the path to the wordlists folder: " wordlist_path
    [ -d "$wordlist_path" ] || error_exit "Invalid directory path. Please provide a valid path."
}

# Function to prompt the user for a file path
function prompt_for_file {
    read -p "Enter the path to the file: " file_path
    [ -e "$file_path" ] || error_exit "File not found. Please provide a valid file path."
}

# Step 1: Navigate to John the Ripper directory
cd /path/to/john-the-ripper || error_exit "John the Ripper not found. Please install it or provide the correct path."

# Step 2: Navigate to the wordlists folder
[ -d "/usr/share/wordlists" ] || prompt_for_directory
cd /usr/share/wordlists || error_exit "Wordlists folder not found. Exiting."

# Step 3: Show the contents of the wordlists folder
echo "Contents of the wordlists folder:"
ls

# Step 4: Ask the user to choose a password txt file
read -p "Enter the name of the password txt file: " password_file
[ -f "$password_file" ] || error_exit "File not found. Please provide a valid file name."

# Step 5: Ask the user for usernames or to locate a username txt file
read -p "Do you have specific usernames? (yes/no): " has_usernames
if [ "$has_usernames" == "yes" ]; then
    read -p "Enter the usernames (comma-separated): " usernames
else
    prompt_for_file
    usernames_file="$file_path"
fi

# Step 6: Run John the Ripper with the specified information
echo "Running John the Ripper..."
john --wordlist="$password_file" --users="$usernames" --format=Raw-SHA256

# Additional steps can be added based on specific requirements or customization.

