import tomllib
import shutil
import os
import sys
import pathlib
import filecmp
import argparse
import datetime

def readFile(source):
    try:
        with open(source, 'rb') as file:
            return tomllib.load(file)
    except tomllib.TOMLDecodeError as error:
        printError(f'Failed to read config: {error}')
        sys.exit(1)

def getPath(file, depth):
    path = pathlib.Path(file)
    return '/'.join(path.parts[-depth:])

def copyFile(src, dest, relPath):
    if not os.path.exists(src):
        printError(f'Source file does not exist: {src}')
        return
    createDir(dest.parent)
    printAction(src, dest, relPath)
    if os.path.exists(dest) and filecmp.cmp(src, dest):
        return
    shutil.copyfile(src, dest)

def copyFiles(section, files, depth):
    path = f'{destination}/{section}/'

    for file in files:
        dest = pathlib.Path(f'{path}/{getPath(file, depth)}')
        relPath = f'{section}/{getPath(file, depth)}'
        copyFile(file, dest, relPath)

def copyDir(dest, directory):
    try:
        files = [entry.path for entry in os.scandir(directory) if entry.is_file()]
    except FileNotFoundError as error:
        printError(f'Invalid directory: {error}')
        return
    
    copyFiles(dest, files, 1)

def printColored(color, text, p=True):
    codes = {
        'red': '\033[91m', 
        'green': '\033[92m', 
        'yellow': '\033[93m', 
        'blue': '\x1b[34m', 
        'white': '\033[37m', 
        'purple': '\033[95m'}

    if p:
        print(f"{codes[color]}{text}\033[0m")
    else:
        return f"{codes[color]}{text}\033[0m"

def printAction(src, dest, relPath):
    if not pathlib.Path.exists(dest):
        color, message = 'green', '[+]'
        stats['new'] += 1
    elif filecmp.cmp(src, dest):
        color, message = 'yellow', '[=]'
        stats['same'] += 1
        if skipUnchanged:
            return
    else:
        color, message = 'purple', '[*]'
        stats['changed'] += 1
    printColored(color, f'{message} {src} ->  {relPath}')

def printStats(stats):
    print(
        f'{printColored('green', f'Created: {stats['new']}', False)} '      \
        f'{printColored('yellow', f'Unchanged: {stats['same']}', False)} '  \
        f'{printColored('purple', f'Changed: {stats['changed']}', False)} ' \
        f'{printColored('red', f'Failed: {stats['failed']}', False)}'
    )
    
def printError(error):
    printColored('red', f'[!] {error}')
    stats['failed'] += 1

def createDir(path):
    if not os.path.exists(path):
        os.makedirs(path)

def getTime():
    return datetime.datetime.now().strftime("%H-%M-%d-%m-%Y")

def parseFlags():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-c', '--config',
        default = f'{os.getcwd()}/config.toml',
        help = 'set custom config file path (default: config.toml)'
    )
    parser.add_argument(
        '-d', '--destination',
        default = f'{os.getcwd()}/backup-{getTime()}',
        help='set custom destination path (default: backup)'
    )
    parser.add_argument(
        '-s', '--skip-unchanged',
        action = 'store_true',
        help = 'skip unchanged files in log'
    )
    parser.add_argument(
        '-b', '--disable-banner',
        action = 'store_true',
        help = 'disable decorative banner'
    )
    args = parser.parse_args()
    return args.config, args.destination, args.skip_unchanged, args.disable_banner

def main():
    global stats, destination, skipUnchanged

    banner = r'''
┌──────────────────────────────────┐
│  _         _                     │
│ | |__  ___| |__ ___  _ __ _  _   │
│ | '_ \/ _ \ '_ (_-<_| '_ \ || |  │
│ |_.__/\___/_.__/__(_) .__/\_, |  │
│                     |_|   |__/   │
│ barely operational backup script │
└──────────────────────────────────┘
              '''
    configName, destination, skipUnchanged, disableBanner = parseFlags()
    if not disableBanner:
        printColored('blue', banner)
    config = readFile(configName)
    stats = {'new': 0, 'same': 0, 'changed': 0, 'failed': 0}

    printColored('blue', f'Config: {configName}')
    printColored('blue', f'Destination: {destination}')

    createDir(destination)
    for section, items in config.items():
        if section == 'dirs':
            for dest, directory in items.items():
                copyDir(dest, directory)
        else:
            copyFiles(section, items.get('files', []), items.get('depth'))
    printStats(stats)

main()