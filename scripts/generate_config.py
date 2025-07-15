#!/usr/bin/env python3
"""
Generate Providentia configuration file (.makerc-vars)
This script interactively creates configuration settings for the Providentia deployment.
"""
import sys
import os

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def main():
    """
    Interactive configuration generator for Providentia deployment.
    Prompts user for environment and Docker sudo preferences, then
    writes them to .makerc-vars configuration file.
    """
    valid_environments = ['dev', 'prod']

    # Get environment setting
    while True:
        environment = input(f'{bcolors.HEADER}[*] Enter your Providentia environment ({"/".join(valid_environments)}): {bcolors.ENDC}')
        if environment.lower() in valid_environments:
            environment = environment.lower()  # Normalize case
            break
        else:
            print(f'{bcolors.WARNING}[*] Please select one of the supported environments: {", ".join(valid_environments)}{bcolors.ENDC}')

    # Get sudo preference
    while True:
        sudo = input(f'{bcolors.HEADER}[*] Are you using sudo to launch docker? [Y/n]: {bcolors.ENDC}')
        if sudo == '':
            sudo = 'y'

        if sudo.lower() in ['y', 'n']:
            break
        else:
            print(f'{bcolors.WARNING}[*] Please choose Y or N{bcolors.ENDC}')

    # Get network exposure setting
    while True:
        network_mode = input(f'{bcolors.HEADER}[*] Will the app run locally or be exposed to network? [local/network]: {bcolors.ENDC}')
        if network_mode.lower() in ['local', 'network']:
            network_mode = network_mode.lower()
            break
        else:
            print(f'{bcolors.WARNING}[*] Please choose "local" or "network"{bcolors.ENDC}')

    # Set domain based on network mode
    if network_mode == 'local':
        domain = 'localhost'
        print(f'{bcolors.OKBLUE}[+] Using "localhost" as domain{bcolors.ENDC}')
    else:
        domain = input(f'{bcolors.HEADER}[*] Enter the domain name to use: {bcolors.ENDC}')
        print(f'{bcolors.WARNING}[!] IMPORTANT: Make sure "providentia.{domain}" and "zitadel.{domain}" resolve to this machine\'s IP address.{bcolors.ENDC}')
        print(f'{bcolors.WARNING}[!] Either add it to your hosts file or configure DNS properly.{bcolors.ENDC}')

    # Write configuration to file
    try:
        with open('./.makerc-vars', 'w+') as f:
            f.write(f'DEPLOY_ENVIRONMENT := {environment}\n')
            f.write(f'SUDO_COMMAND := {"sudo -E" if sudo.lower()=="y" else ""}\n')
            f.write(f'APP_DOMAIN := {domain}\n')
        print(f'{bcolors.OKGREEN}[+] Configuration saved successfully to .makerc-vars{bcolors.ENDC}')
    except IOError as e:
        print(f'{bcolors.FAIL}[!] Error writing configuration file: {e}{bcolors.ENDC}')
        return 1

    return 0

if __name__ == '__main__':
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print('\n')
        try:
            sys.exit(130)
        except SystemExit:
            os._exit(130)