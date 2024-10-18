#!/usr/bin/env python3

import os
import hashlib
import argparse

CONFIG_LISTS = ['contest-service', 'filesys-service', 'gateway', 'judger-service', 'problem-service', 'user-service', 'websocket-service']
CONFIG_SUFFIX = 'yml'
NACOS_STRUCT = {
        'GROUP': 'DEFAULT_GROUP',
        'GMT_CREATE': '2024-01-01 00:00:00',
        'GMT_MODIFIED': '2024-01-01 00:00:00',
        'SRC_USER': 'sduoj',
        'SRC_IP': '127.0.0.1',
        'APP_NAME': 'sduoj',
        'TENANT_ID': 'prod',
        'TYPE': 'yaml',
}

def calc_md5(s):
    md = hashlib.md5()
    md.update(s.encode('utf-8'))
    return md.hexdigest()

def gen_config(args):
    for key, value in NACOS_STRUCT.items():
        print(f"{key}: {value}")

    sqls = []
    for i, cfg in enumerate(CONFIG_LISTS):
        path = os.path.join(args.dir, f"{cfg}.{CONFIG_SUFFIX}")
        print(path)
        with open(path, 'r') as f:
            texts = f.read()

        post_texts = ""
        for c in texts:
            if c == '\n':
                post_texts += '\\n'
            elif c == '"':
                post_texts += '\\"'
            elif c == "'":
                post_texts += "\\'"
            else:
                post_texts += c

        md5 = calc_md5(texts)
        sql = f"INSERT INTO `config_info` VALUES ('{i+1}', '{cfg + '.' + CONFIG_SUFFIX}', '{NACOS_STRUCT['GROUP']}', '{post_texts}', '{md5}', \
                    '{NACOS_STRUCT['GMT_CREATE']}', '{NACOS_STRUCT['GMT_MODIFIED']}', '{NACOS_STRUCT['SRC_USER']}', '{NACOS_STRUCT['SRC_IP']}', \
                    '{NACOS_STRUCT['APP_NAME']}', '{NACOS_STRUCT['TENANT_ID']}', '', '', '', '{NACOS_STRUCT['TYPE']}', '', '');"

        sqls.append(sql)
        print(cfg)
        print(post_texts)
        print(md5)
        print(sql)
        print('------------------------------')

    with open(args.output, 'w') as f:
        for sql in sqls:
            f.write(f"{sql}\n")

 
def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dir', required=True, type=str, help='Directory of Nacos configs')
    parser.add_argument('--output', type=str, default='output.sql', help='SQL cmd file for Nacos configs')
    return parser.parse_args()

def main():
    args = parse_args()
    gen_config(args)

if __name__ == '__main__':
    main()
