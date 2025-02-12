#!/bin/bash

ESCAPE_CODE="instantwarp42"
PASSWORD="opensesame"
VAULT_CORRUPTED="wraFats123p"

mkdir -p logs multiplayer

# 🕹️ start the Game
if [[ "$1" == "room" ]]; then
    echo "🔒 The Old Terminal has detected you."
    echo "Zach Lloyd left a hidden escape sequence. Find it before The Old Terminal LOCKs you in forever."
    date +%s > logs/start_time.log
    exit 0
fi

# 🔐 Puzzle 1: Unlocking the door
if [[ "$1" == "door" ]]; then
    echo "🚪 The Old Terminal has locked all exits."
    echo "Zach’s last message is in 'zach_message.enc'. Read it and find the password."
    exit 0
fi

if [[ "$1" == "unlock" && "$2" == "$PASSWORD" ]]; then
    echo "✅ The door unlocks!"
    exit 0
elif [[ "$1" == "unlock" ]]; then
    echo "❌ Incorrect password. Search the logs."
    exit 1
fi

# 🔍 Puzzle 2: finding the secret transmission
if [[ "$1" == "transmission" ]]; then
    echo "📡 The Old Terminal is blocking communications."
    echo "Zach left a video message. Retrieve it using 'curl -O https://warp.dev/secret_transmission.mp4'."
    exit 0
fi

# 🔓 Puzzle 3: The vault key
if [[ "$1" == "vault" ]]; then
    echo "🔒 The vault key is corrupted."
    echo "Fix 'vault.key' using 'nano' or 'vim' to restore access."
    exit 0
fi

# 🤝 Puzzle 4: multiplayer escape
if [[ "$1" == "team" && "$2" == "invite" ]]; then
    echo "📢 Invite a teammate using 'team invite <player>'"
    exit 0
fi

if [[ "$1" == "team" && "$2" == "unlock" ]]; then
    touch multiplayer/player1.ready
    echo "🔑 Waiting for the second player..."
    
    if [[ -f multiplayer/player2.ready ]]; then
        echo "✅ Both players are ready! The final door unlocks!"
        exit 0
    fi
    exit 0
fi

if [[ "$1" == "team" && "$2" == "join" ]]; then
    touch multiplayer/player2.ready
    echo "👥 You joined the escape! Waiting for player 1..."
    
    if [[ -f multiplayer/player1.ready ]]; then
        echo "✅ Both players are ready! The final door unlocks!"
        exit 0
    fi
    exit 0
fi

# 🚀 Puzzle 5: running the Last command
if [[ "$1" == "shutdown" ]]; then
    echo "⚠️ The Old Terminal refuses to shut down. Manual override required."
    echo "Check 'last_command.sh' for the final sequence."
    exit 0
fi

if [[ "$1" == "escape" && "$2" == "$ESCAPE_CODE" ]]; then
    date +%s > logs/end_time.log
    START_TIME=$(cat logs/start_time.log)
    END_TIME=$(cat logs/end_time.log)
    TIME_TAKEN=$((END_TIME - START_TIME))
    echo "Player escaped in $TIME_TAKEN seconds" >> logs/leaderboard.log
    echo "🚀 You escaped in $TIME_TAKEN seconds!"
    echo "🏆 Check the leaderboard: 'cat logs/leaderboard.log'"
    exit 0
fi

# 💀 Final shutdown attempt (The Old Terminal Resists)
if [[ "$1" == "finalshutdown" ]]; then
    echo "💀 The Old Terminal is resisting shutdown..."
    echo "This is your last chance."
    echo "Run the final command now or be trapped forever."
    exit 0
fi

echo "❌ Invalid command. Use 'room' to start or 'escape <code>' to escape."
exit 1
