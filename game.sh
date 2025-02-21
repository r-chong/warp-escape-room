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

    # Reset files
    echo "wraFats123p" > security/vault.key
    echo "PASSWORD=opensesame" > security/system_logs.txt

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

    cat << EOF > security/zach_message.enc
"The key is hidden in the system logs. GREP what you need.
- Z.L.
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

# Start the monitoring script in the background
./monitor.sh &

# Define color variables
RED='\033[0;31m'
BOLD_WHITE='\033[1;37m'
RESET='\033[0m' # Reset color to default

echo -e "=========================================================="
echo -e "I was only supposed to run a routine check."
echo -e "But when I logged in, The Old Terminal activated;"
echo -e "a long-forgotten backup system from the early days of computing.\n"

echo -e "They left The Old Terminal running because they thought it was harmless."
echo -e "Just an obsolete failsafe."
echo -e "But it's still following orders.\n"

echo -e "${BOLD_WHITE}Orders no one remembers.${RESET}\n"

echo -e "Zach Lloyd saw this coming."
echo -e "Before he vanished, he left behind a final failsafe,"
echo -e "buried deep in the mainframe—a message hidden inside 'zach_message.enc'.\n"

echo -e "It's too late for me. But not for you.\n"

echo -e "Shut down The Old Terminal, for the good of the world.\n"

# Extra line with emphasis
echo -e "${BOLD_WHITE}Explore the system freely. Type 'help' if you're lost.${RESET}"
echo -e "=========================================================="