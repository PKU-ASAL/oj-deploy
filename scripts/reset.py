#!/usr/bin/env python3

import os
import argparse, subprocess

def run_reset(args):
    files = ['data/mysql/data', 'data/mysql/files', 'data/nacos/logs', 'data/sduoj/logs']

    paths = []
    for file in files:
        path = os.path.join(args.dir, file)
        paths.append(path)
        print(path)

    for path in paths:
        subprocess.run(f"rm -rf {path}", shell=True)

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dir', required=True, type=str, help='The directory of OJ deployment')
    return parser.parse_args()

def main():
    args = parse_args()
    run_reset(args)

if __name__ == '__main__':
    main()
