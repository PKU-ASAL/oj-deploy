#!/usr/bin/env python3

import os
import json
import requests
import argparse

LOGIN_API = "/api/user/login"
LOGOUT_API = "/api/user/logout"
UPLOAD_API = "/api/checkpoint/upload"
APPEND_API = "/api/problem/appendCheckpoints"

def validate_response(response, action):
    data = response.json()
    if data['code'] != 0:
        print(f"{action} failed")
        print(data['code'], data['message'])
        exit(-1)
    return data['data']    

def login(args):
    url = args.host + LOGIN_API
    header = {
        "accept": "application/json, text/plain, */*",
        "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36",
        "content-type": "application/json;charset=UTF-8",
        "Origin": args.host,
    }
    data = {
        "username": args.user,
        "password": args.passwd
    }
    session = requests.Session()
    response = session.post(url, data=json.dumps(data), headers=header)
    validate_response(response, 'login')
    return session

def upload(session, in_data, out_data, args):
    url = args.host + UPLOAD_API
    header = {
        "accept": "application/json, text/plain, */*",
        "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36",
        "content-type": "application/json;charset=UTF-8",
        "Origin": args.host,
    }
    data = {
        "input": in_data,
        "output": out_data,
        "mode": args.mode
    }
    response = session.post(url, data=json.dumps(data), headers=header)
    return validate_response(response, 'upload')

def update(session, checkpoints, args):
    url = args.host + APPEND_API
    header = {
        "accept": "application/json, text/plain, */*",
        "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36",
        "content-type": "application/json;charset=UTF-8",
        "Origin": args.host,
    }
    data = {
        "type": 1,
        "problemId": args.problem,
        "checkpoints": checkpoints
    }
    response = session.post(url, data=json.dumps(data), headers=header)
    data = validate_response(response, 'update')

def logout(session, args):
    url = args.host + LOGOUT_API
    response = session.get(url)
    return validate_response(response, 'logout')

def run(args):
    data_files = []
    for root, _, files in os.walk(args.dir):
        for in_file in files:
            if in_file.endswith(".in"):
                out_file = in_file[:-3] + ".out"
                in_path = os.path.join(root, in_file)
                out_path = os.path.join(root, out_file)
                data_files.append([in_path, out_path])
    print(f"Found {len(data_files)} dataset")

    chkpoints = []
    session = login(args)
    for i, path in enumerate(data_files):
        in_path, out_path = path
        with open(in_path, "r") as f:
            in_data = f.read()
        with open(out_path, "r") as f:
            out_data = f.read()
        print(f"Uploading data {i+1}: {in_path} {out_path}")
        chkpoint = upload(session, in_data, out_data, args)
        if chkpoint is None:
            print("Upload failed")
        else:
            print("Upload checkpoint", chkpoint['checkpointId'])
            chkpoints.append(chkpoint)

    print(f"Update {len(chkpoints)} checkpoints")
    update(session, chkpoints, args)
    logout(session, args)

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--user', required=True, type=str, help='Username')
    parser.add_argument('--passwd', required=True, type=str, help='Password')
    parser.add_argument('--host', default='localhost', type=str, help='OJ Hostname, default is localhost')
    parser.add_argument('--mode', type=str, default='dos2unix', choices=['dos2unix', 'unix2dos', ''], help='Format mode, default is dos2unix')
    parser.add_argument('--problem', type=str, required=True, help='The problemId to add public checkpoints')
    parser.add_argument('--dir', type=str, default='.', help='The directory for checkpoints, all will be uploaded, files should be in pair, default is CWD')
    return parser.parse_args()

def main():
    args = parse_args()
    run(args)

if __name__ == '__main__':
    main()
