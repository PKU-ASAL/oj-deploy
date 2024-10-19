#!/usr/bin/env python3

import sys
import argparse

DESCRIPTION = '''
Generate MySQL commands to convert problemCode. 
For example, to convert the problemCode `SDUOJ-1000` to `PKU-1000`, execute `./updatePcode.py --code=1000 --prefix_new=PKU --prefix_old=SDUOJ`.

The script will generate several SQL commands, you can put them into a .sql file and execute inside the MySQL Database.
'''

def eprint(*args, **kwargs):
    print(*args, **kwargs, file=sys.stderr)

def run(args):
    codes = args.codes.split(',')
    if len(codes) == 0:
        eprint("empty problemCodes")

    for code in codes:
        print(f"UPDATE `{args.table}` SET `{args.field}` = '{args.prefix_new}-{code}' WHERE `{args.field}` = '{args.prefix_old}-{code}';")

def parse_args():
    parser = argparse.ArgumentParser(description=DESCRIPTION)
    parser.add_argument('--codes', type=str, required=True, help='Those problemCodes that should be updated, split by ","')
    parser.add_argument('--prefix_new', type=str, default='PKU', help='The new prefix of problemCode, default is `PKU`')
    parser.add_argument('--prefix_old', type=str, default='SDUOJ', help='The old prefix of problemCode, default is `SDUOJ`')
    parser.add_argument('--table', type=str, default='oj_problem', help='The table of problems in the database, default is `oj_problem`')
    parser.add_argument('--field', type=str, default='p_code', help='The field name of problemCode in the database, default is `p_code`')
    return parser.parse_args()

def main():
    args = parse_args()
    run(args)

if __name__ == '__main__':
    main()
