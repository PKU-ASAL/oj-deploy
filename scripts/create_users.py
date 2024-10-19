#!/usr/bin/env python3

import csv
import hashlib
import argparse
from datetime import datetime

DESCRIPTION = """
Generate MySQL commands to create users in bacth.

The input file is in CSV format, each line is like `username,nickname,password`
The script will generate MySQL commands and execute them inside the database to make it work.
"""

def calc_md5(salt, passwd):
    md5_salt = hashlib.md5()
    md5_passwd = hashlib.md5()
    md5_passwd.update(passwd)
    md5_salt.update(salt + md5_passwd.hexdigest)
    return md5_salt.hexdigest()

def run(args):
    features = '{\"banThirdParty\":1,\"banEmailUpdate\":1,\"banInfoUpdate\":1,\"requirePasswordChange\":0}'
    current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S') 

    with open(args.csv, 'r') as f:
        spamreader = csv.reader(f, delimiter=',')

    for row in spamreader:
        username, nickname, password = row
        password = calc_md5(args.salt, password)
        email = f"{username}@stu.pku.edu.cn"
        print(f"INSERT INTO `{args.table}` VALUES (null, '{current_time}', '{current_time}', '{features}', '0', '0', '{username}', '{nickname}', '{args.salt}', '{password}', '{email}', '1', '12345678910', '2', '{username}', null, 'user')")

def parse_args():
    parser = argparse.ArgumentParser(description=DESCRIPTION)
    parser.add_argument('--csv', required=True, type=str, help='CSV file for users')
    parser.add_argument('--table', type=str, default='oj_user', help='The table of users, default is `oj_user`')
    parser.add_argument('--salt', type=str, default='salt_', help='The salty for password encryption, default is `salt_`')
    return parser.parse_args()

def main():
    args = parse_args()
    run(args)

if __name__ == '__main__':
    main()
