#!/bin/bash

PROGRESS_FILE="logs/progress.log"

sleep 3
echo "🔒 The Old Terminal has detected you. Your actions are being watched."
sleep 2
echo "Explore the system and uncover the truth. If you're lost... ask the right questions."

# Background monitoring loop
while true; do
    sleep 3  # Prevent CPU overload

    PROGRESS=$(cat "$PROGRESS_FILE" 2>/dev/null || echo "0")

    case "$PROGRESS" in

        "0")
            # The first major hint
            if grep -q "PASSWORD=opensesame" security/system_logs.txt 2>/dev/null; then
                echo "🟢 Something from the past still lingers... but only for those who know where to look."
                echo "1" > "$PROGRESS_FILE"
            fi
            ;;

        "1")
            # Cryptic message for door unlocking
            if [[ "$(cat security/door.lock 2>/dev/null)" == "opensesame" ]]; then
                echo "✅ The door unlocks."
                echo "🚪 But doors don’t open without a cost. Who left this here?"
                echo "2" > "$PROGRESS_FILE"
            fi
            ;;

        "2")
            # Message for the transmission discovery
            if [[ -f "warp_network/secret_transmission.mp4" ]]; then
                echo "📡 The airwaves are not as silent as they seem. A voice from the past is calling."
                echo "3" > "$PROGRESS_FILE"
            fi
            ;;

        "3")
            # Message when the vault key is fixed
            if [[ "$(cat security/vault.key 2>/dev/null)" == "warpfast123" ]]; then
                echo "🔓 The vault opens, but was it locked to keep something out... or in?"
                echo "4" > "$PROGRESS_FILE"
            fi
            ;;

        "4")
            # Multiplayer hint
            if [[ -f multiplayer/player1.ready && -f multiplayer/player2.ready ]]; then
                echo "👥 No one escapes alone. Some locks require two keys."
                echo "🔓 The final lock disengages..."
                echo "5" > "$PROGRESS_FILE"
            fi
            ;;

        "5")
            # Final message before shutdown attempt
            if [[ -x security/last_command.sh ]]; then
                echo "💀 The Old Terminal resists. Its last directive was never meant to be broken."
                echo "> The system is holding on. Do you?"
                echo "6" > "$PROGRESS_FILE"
            fi
            ;;

        "6")
            echo "🔥 SYSTEM OVERRIDE ENGAGED"
            echo "FATAL ERROR."
            echo "DIRECTIVE: TERMINATE."
            echo "THE OLD TERMINAL SHUTTING DOWN..."
            echo "🚀 You escaped in X seconds!"
            exit 0
            ;;
    esac
done
