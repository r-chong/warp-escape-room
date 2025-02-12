#!/bin/bash

# Load configuration from separate file
source "$(dirname "$0")/config.sh"

mkdir -p logs multiplayer security warp_network

PROGRESS_FILE="logs/progress.log"

# Reset game to default state
if [[ "$1" == "reset" ]]; then
    echo "🔄 Resetting game to default state..."

    # Reset progress tracking
    echo "0" > "$PROGRESS_FILE"

    # Reset door.lock
    cat << EOF > security/door.lock
╔══════════════════════════════════════════╗
║  SYSTEM LOCK ENGAGED: UNAUTHORIZED ACCESS  ║
╚══════════════════════════════════════════╝

> If you are reading this…  
> The system still knows.  
> But memory is longer than they think.  
> Some things don’t erase so easily.  
> Logs contain all. If you know where to look.  
EOF

    # Reset system logs
    cat << EOF > security/system_logs.txt
[LOG INIT] SYSTEM LOGS INITIALIZED - [TIMESTAMP: 03:14:07 UTC]  
[SYS ALERT] Unauthorized access detected. Locking security protocols...  
[INFO] Password cache updated: PASSWORD=opensesame  
[SECURITY] Warning: System monitoring active  
EOF

    # Reset zach_message.enc
    cat << EOF > security/zach_message.enc
"It was supposed to be forgotten. Just a relic. A failsafe collecting dust in the mainframe. But it never stopped running. Never stopped listening. Never stopped waiting.

If you’re seeing this, The Old Terminal has activated.

They thought they were in control. They were wrong.

Find the last command. Before it finds you."  
EOF

    # Reset vault.key (corrupted)
    echo "wraFats123p" > security/vault.key

    # Reset last_command.sh
    cat << EOF > security/last_command.sh
#!/bin/bash  
# If you see this, it means I failed.  
# The Old Terminal isn’t just running old scripts—it’s following an original directive.  
# It was never supposed to be turned off. Ever.  
# But there’s a backdoor… hidden in plain sight.  
# Run the last command, and it all shuts down.  

shutdown -h now
EOF

    # Remove any previously downloaded files
    rm -f warp_network/secret_transmission.mp4
    rm -f multiplayer/player1.ready multiplayer/player2.ready

    # Unset sensitive variables
    unset PASSWORD
    unset ESCAPE_CODE

    echo "✅ Reset complete. Type 'start' to begin your escape."
    exit 0
fi

# Welcome message
echo "🎮 Welcome to The Old Terminal Escape Room!"
echo "Type 'start' to begin or 'help' for commands."

# Start interactive game loop
while true; do
    echo -n "> "  
    read -r input args

    case "$input" in

        "help")
            echo "Available commands:"
            echo "  start         - Begin the escape"
            echo "  door          - Examine the locked door"
            echo "  unlock        - Try to unlock the door"
            echo "  transmission  - Check for transmissions"
            echo "  vault         - Examine the vault"
            echo "  team          - Multiplayer options"
            echo "  shutdown      - Attempt system shutdown"
            echo "  reset         - Restart the game from scratch"
            ;;

        "start")
            echo "🔒 The Old Terminal has detected you."
            echo "Zach Lloyd left a hidden escape sequence. Find it before The Old Terminal locks you in forever."
            date +%s > logs/start_time.log
            ;;

        "door")
            echo "🚪 The Old Terminal has locked all exits."
            echo "Zach's last message is in 'zach_message.enc'. Read it and find the password."
            ;;

        "cat security/zach_message.enc")
            cat security/zach_message.enc
            ;;

        "grep PASSWORD security/system_logs.txt")
            grep "PASSWORD" security/system_logs.txt
            ;;

        "unlock")
            echo -n "Enter password: "
            read -r user_input
            if [[ "$user_input" == "opensesame" ]]; then
                echo "✅ The door unlocks!"
                echo "🚪 You push forward. The system resists..."
                echo "1" > "$PROGRESS_FILE"
            else
                echo "❌ Incorrect password. Search the logs."
            fi
            ;;

        "transmission")
            echo "📡 The Old Terminal is blocking communications."
            echo "Zach left a video message. Retrieve it using 'curl -O https://warp.dev/secret_transmission.mp4'."
            ;;

        "curl -O https://warp.dev/secret_transmission.mp4")
            echo "📥 Downloading... Complete."
            echo "▶️ Run 'ffplay warp_network/secret_transmission.mp4' to watch."
            ;;

        "vault")
            echo "🔒 The vault key is corrupted."
            echo "Fix 'vault.key' using 'nano' or 'vim' to restore access."
            ;;

        "nano security/vault.key")
            echo "🛠 Edit the file and fix the key manually."
            ;;

        "echo warpfast123 > security/vault.key")
            echo "✅ Vault Key Restored!"
            echo "🔓 A new directory unlocks: 'core_process/'"
            ;;

        "team")
            echo "📢 Multiplayer mode: Invite a teammate using 'team invite'."
            ;;

        "team invite")
            touch multiplayer/player1.ready
            echo "🔑 Waiting for the second player..."
            ;;

        "team join")
            touch multiplayer/player2.ready
            echo "👥 You joined the escape! Waiting for player 1..."
            if [[ -f multiplayer/player1.ready ]]; then
                echo "✅ Both players are ready! The final door unlocks!"
            fi
            ;;

        "ls security")
            echo "📂 Available files: door.lock  zach_message.enc  system_logs.txt  vault.key  last_command.sh"
            ;;

        "nano security/last_command.sh")
            echo "💾 You open the file. Inside, you see:"
            cat security/last_command.sh
            ;;

        "chmod +x security/last_command.sh")
            echo "🛠 File permissions updated."
            ;;

        "./security/last_command.sh")
            echo "💀 The Old Terminal resists."
            echo "> ACCESS DENIED"
            echo "> The Old Terminal has locked this process."
            echo "> Attempting to exit? (y/n)"
            ;;

        "y")
            echo "🔥 SYSTEM OVERRIDE ENGAGED"
            echo "FATAL ERROR."
            echo "DIRECTIVE: TERMINATE."
            echo "THE OLD TERMINAL SHUTTING DOWN..."
            echo "🚀 You escaped in X seconds!"
            exit 0
            ;;

        "reset")
            ./game.sh reset
            exit 0
            ;;

        *)
            echo "❌ Invalid command. Type 'help' for available actions."
            ;;
    esac
done
