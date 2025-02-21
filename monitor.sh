#!/bin/bash

PROGRESS_FILE="logs/progress.log"

sleep 3
clear  # Clear screen initially
tput cup 0 0
echo -e "\U0001F512 The Old Terminal has detected you. Your actions are being watched."
tput cup $(($(tput lines)-2)) 0
sleep 2
tput cup 1 0
echo "Explore the system and uncover the truth. If you're lost... ask the right questions."
sleep 1
echo
sleep 2
echo "To read the instructions again, open the mission_briefing.txt file."
sleep 2
echo "You can begin to run commands by opening a new terminal tab."
sleep 2
echo "Good luck!"
tput cup $(($(tput lines)-2)) 0
echo    # Empty echo will print a newline

# Background monitoring loop
while true; do
    sleep 3  # Prevent CPU overload

    PROGRESS=$(cat "$PROGRESS_FILE" 2>/dev/null || echo "0")

    case "$PROGRESS" in
        "0")
            # The first major hint
            if grep -q "PASSWORD=opensesame" security/system_logs.txt 2>/dev/null; then
                tput cup 3 0
echo -e "\U0001F7E2 Something from the past still lingers... but only for those who know where to look."
tput cup $(($(tput lines)-2)) 0
                echo "1" > "$PROGRESS_FILE"
            fi
            ;;

        "1")
            # Cryptic message for door unlocking
            if [[ "$(cat security/door.lock 2>/dev/null)" == "opensesame" ]]; then
                tput cup 4 0
echo "✅ The door unlocks."
tput cup $(($(tput lines)-2)) 0
                tput cup 5 0
echo -e "\U0001F6AA But doors don't open without a cost. Who left this here?"
tput cup $(($(tput lines)-2)) 0
                echo "2" > "$PROGRESS_FILE"
            fi
            ;;

        "2")
            # Message for the transmission discovery
            if [[ -f "warp_network/secret_transmission.mp4" ]]; then
                tput cup 6 0
echo -e "\U0001F4E1 The airwaves are not as silent as they seem. A voice from the past is calling."
tput cup $(($(tput lines)-2)) 0
                echo "3" > "$PROGRESS_FILE"
            fi
            ;;

        "3")
            # Message when the vault key is fixed
            if [[ "$(cat security/vault.key 2>/dev/null)" == "warpfast123" ]]; then
                tput cup 7 0
echo -e "\U0001F513 The vault opens, but was it locked to keep something out... or in?"
tput cup $(($(tput lines)-2)) 0
                echo "4" > "$PROGRESS_FILE"
            fi
            ;;

        "4")
            # Multiplayer hint
            if [[ -f multiplayer/player1.ready && -f multiplayer/player2.ready ]]; then
                tput cup 8 0
echo -e "\U0001F465 No one escapes alone. Some locks require two keys."
tput cup $(($(tput lines)-2)) 0
                tput cup 9 0
echo -e "\U0001F513 The final lock disengages..."
tput cup $(($(tput lines)-2)) 0
                echo "5" > "$PROGRESS_FILE"
            fi
            ;;

        "5")
            # Final message before shutdown attempt
            if [[ -x security/last_command.sh ]]; then
                tput cup 10 0
echo -e "\U0001F480 The Old Terminal resists. Its last directive was never meant to be broken."
tput cup $(($(tput lines)-2)) 0
                tput cup 11 0
echo "> The system is holding on. Do you?"
tput cup $(($(tput lines)-2)) 0
                echo "6" > "$PROGRESS_FILE"
            fi
            ;;

        "6")
            tput cup 12 0
echo -e "\U0001F525 SYSTEM OVERRIDE ENGAGED"
tput cup $(($(tput lines)-2)) 0
            tput cup 13 0
echo "FATAL ERROR."
tput cup $(($(tput lines)-2)) 0
            tput cup 14 0
echo "DIRECTIVE: TERMINATE."
tput cup $(($(tput lines)-2)) 0
            tput cup 15 0
echo "THE OLD TERMINAL SHUTTING DOWN..."
tput cup $(($(tput lines)-2)) 0
            tput cup 16 0
echo -e "\U0001F680 You escaped in X seconds!"
tput cup $(($(tput lines)-2)) 0
            exit 0
            ;;
    esac
done
