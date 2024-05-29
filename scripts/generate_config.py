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
  environment = ''
  sudo = ''
  valid_environments = ['dev', 'prod']

  while True:
    environment = input(f'{bcolors.HEADER}[*] Enter your Providentia environment {valid_environments}: {bcolors.ENDC}')

    if environment in valid_environments:
        break
    else:
        print('[*] Pick one of supported environments')
        continue

  while True:
    sudo = input(f'{bcolors.HEADER}[*] Are you using sudo to launch docker? [Y/n]: {bcolors.ENDC}')
    if sudo == '':
      sudo = 'y'

    if sudo.lower() in ['y', 'n']:
        break
    else:
        print('[*] Choose Y or N')
        continue

  with open('./.makerc-vars', 'w+') as f:
    f.write(f'DEPLOY_ENVIRONMENT := {environment}\n')
    f.write(f'SUDO_COMMAND := {"sudo" if sudo.lower()=="y" else ""}\n')
    f.close();

if __name__ == '__main__':
  try:
    main()
  except KeyboardInterrupt:
    print('\n')
    try:
      sys.exit(130)
    except SystemExit:
      os._exit(130)