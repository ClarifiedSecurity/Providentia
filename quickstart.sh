#!/bin/sh
# Download Providentia compose files from GitHub repository

GITHUB_REPO="https://raw.githubusercontent.com/ClarifiedSecurity/Providentia/v25.6.1"

# Color codes (only if terminal supports it)
if [ -t 1 ]; then
    RED='\033[0;31m' GREEN='\033[0;32m' YELLOW='\033[1;33m' BLUE='\033[0;34m' NC='\033[0m'
else
    RED='' GREEN='' YELLOW='' BLUE='' NC=''
fi

# Print functions
print_msg() { printf "%b[*] %s%b\n" "$1" "$2" "$NC"; }
print_success() { print_msg "$GREEN" "$1"; }
print_error() { print_msg "$RED" "$1"; }
print_warning() { print_msg "$YELLOW" "$1"; }

# Check if command exists
has_cmd() { command -v "$1" >/dev/null 2>&1; }

# Download file with curl or wget
download_file() {
    file_path="$1"
    url="${GITHUB_REPO}/${file_path}"

    print_msg "$BLUE" "Downloading $file_path..."

    if has_cmd curl; then
        curl -fsSL -o "$file_path" "$url"
    elif has_cmd wget; then
        wget -q -O "$file_path" "$url"
    else
        print_error "Neither curl nor wget is available"
        return 1
    fi

    if [ $? -eq 0 ]; then
        print_success "Downloaded $file_path"
    else
        print_error "Failed to download $file_path"
        return 1
    fi
}

# Configure environment
configure_env() {
    print_msg "$BLUE" "Configuring environment..."

    while true; do
        printf "%b[*] Run locally or expose to network? [local/network]: %b" "$BLUE" "$NC"
        read -r network_mode < /dev/tty
        network_mode=$(echo "$network_mode" | tr '[:upper:]' '[:lower:]')

        case "$network_mode" in
            local|network) break ;;
            *) print_warning "Please choose 'local' or 'network'" ;;
        esac
    done

    if [ "$network_mode" = "local" ]; then
        domain="localhost"
        print_success "Using 'localhost' as domain"
    else
        printf "%b[*] Enter domain name: %b" "$BLUE" "$NC"
        read -r domain < /dev/tty
        echo ""
        print_warning "IMPORTANT: Ensure 'providentia.$domain' and 'zitadel.$domain' resolve to this machine's IP"
    fi

    # Create .env file
    print_msg "$BLUE" "Creating .env file..."
    cat > .env << EOF || { print_error "Failed to create .env file"; return 1; }
# Providentia configuration
PROVIDENTIA_DOMAIN=providentia.$domain
ZITADEL_DOMAIN=zitadel.$domain
EOF

    print_success "Configuration saved to .env file (domain: $domain)"
}

# Main execution
main() {
    mkdir providentia && cd providentia
    print_msg "$BLUE" "Starting download of Providentia compose files..."

    # Check dependencies
    if ! has_cmd curl && ! has_cmd wget; then
        print_error "Neither curl nor wget is installed. Please install one."
        exit 1
    fi

    # Create support directory
    if [ ! -d "support" ]; then
        print_msg "$BLUE" "Creating support directory..."
        mkdir -p support || { print_error "Failed to create support directory"; exit 1; }
        print_success "Created support directory"
    fi

    # Files to download
    files="support/compose-postgresql.yml support/compose-zitadel.yml support/compose-caddy.yml support/compose-web.yml support/zitadel.tf docker-compose.yml"

    # Download files
    failed=0
    for file in $files; do
        download_file "$file" || failed=$((failed + 1))
    done

    echo ""
    if [ $failed -eq 0 ]; then
        print_success "All files downloaded successfully!"
        echo ""
        configure_env
        echo ""
        print_success "Setup complete! Files and configuration are ready in 'providentia/' directory."
        print_success "Run 'cd providentia && docker compose up' to start the services."
    else
        print_warning "Some files failed to download. Check output above."
        exit 1
    fi
}


main "$@"