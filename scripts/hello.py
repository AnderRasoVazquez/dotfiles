#!/usr/bin/python

from argparse import ArgumentParser # opviones -v -a --verbose
from colorama import Fore, Back, Style # colores
import sys # argumentos

if sys.argv[1]:
    print("1 arg")

if sys.argv[2]:
    print("2 arg")

def main():
    ap = ArgumentParser()
    ap.add_argument('name', nargs='?')
    ap.add_argument('-v', '--verbose', default=False, action='store_true', help='Longer greeetings')
    args = ap.parse_args()
    name = (args.name or 'World')

    if args.verbose:
        print(Fore.RED + "Hello,", name + "! Nice to see you.")
    else:
        print(Back.GREEN + "Hello,", name + "!")

if __name__ == '__main__':
    main()
