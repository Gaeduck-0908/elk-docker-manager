#!/bin/bash
set -e

COMPOSE_FILE="docker-compose.yml"

function init_setting() {
    echo "🔧 Checking Docker installation..."
    if ! command -v docker &> /dev/null; then
        echo "❌ Docker is not installed. Please install Docker first."
        exit 1
    fi

    echo "🔧 Checking Docker Compose installation..."
    if ! command -v docker-compose &> /dev/null; then
        echo "❌ Docker Compose not found. Installing..."
        sudo apt-get update
        sudo apt-get install -y docker-compose
    fi

    echo "✅ Docker & Docker Compose are installed."

    echo "🔧 Setting vm.max_map_count to 131072..."
    sudo sysctl -w vm.max_map_count=131072
    if ! grep -q "vm.max_map_count=131072" /etc/sysctl.conf; then
        echo "vm.max_map_count=131072" | sudo tee -a /etc/sysctl.conf
    fi

    echo "✅ Initialization complete. Ready to start ELK stack."
}

function start_docker() {
    echo "🚀 Starting ELK stack containers..."
    docker-compose -f $COMPOSE_FILE up -d
    echo "✅ ELK stack started."
}

function stop_docker() {
    echo "🛑 Stopping ELK stack containers..."
    docker-compose -f $COMPOSE_FILE down
    echo "✅ ELK stack stopped."
}

function restart_docker() {
    stop_docker
    start_docker
}

function delete_environment() {
    echo "🔥 Deleting ELK containers and volumes..."
    docker-compose -f $COMPOSE_FILE down -v
    echo "✅ ELK environment fully removed."
}

while true; do
    echo ""
    echo "=============================="
    echo "     ELK Stack Manager"
    echo "=============================="
    echo "1) Initialize Environment"
    echo "2) Start ELK Docker Containers"
    echo "3) Stop ELK Docker Containers"
    echo "4) Restart ELK Docker Containers"
    echo "5) Delete ELK Environment (Containers + Volumes)"
    echo "0) Exit"
    read -rp "Select an option: " choice

    case $choice in
        1) init_setting ;;
        2) start_docker ;;
        3) stop_docker ;;
        4) restart_docker ;;
        5) delete_environment ;;
        0) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option. Try again." ;;
    esac
done
