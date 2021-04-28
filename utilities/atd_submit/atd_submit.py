#Written by mohlcyber

import os
import base64
import json
import requests
import argparse

requests.packages.urllib3.disable_warnings()


class ATD():

    def __init__(self):
        self.ip = args.atdip
        self.url = "https://" + self.ip + "/php/"
        self.user = args.atdusername
        self.pw = args.atdpassword
        self.creds = base64.b64encode((self.user + ":" + self.pw).encode('ascii'))
        self.profile = args.atdprofileid
        self.verify = False

        self.ifile = args.file

    def sessionsetup(self):
        sessionheaders = {'VE-SDK-API': self.creds,
                          'Content-Type': 'application/json',
                          'Accept': 'application/vnd.ve.v1.0+json'}
        r = requests.get(self.url + "session.php", headers=sessionheaders, verify=self.verify)
        data = r.json()
        print(json.dumps(data))
        results = data.get('results')

        session = (results['session'] + ':' + results['userId']).encode('ascii')

        self.headers = {'VE-SDK-API': base64.b64encode(session),
                   'Accept': 'application/vnd.ve.v1.0+json',
                   'accept-encoding': 'gzip;q=0,deflate,sdch'}

    def submit_file(self):
        payload = {
            'data': {
                'vmProfileList': self.profile,
                'submitType': '0'
            }
        }

        data = json.dumps(payload)

        try:
            path, filename = os.path.split(self.ifile)
            files = {'amas_filename': (filename, open(self.ifile, 'rb'))}
        except Exception as e:
            print('Error opening the file: ' + str(e))

        try:
            r = requests.post(self.url + "fileupload.php", headers=self.headers, files=files, data={'data': data},
                              verify=self.verify)

            response = r.json()
            print(json.dumps(response))

        except Exception as e:
            print('Error submitting files to ATD: ' + str(e))

    def logout(self):
        r = requests.delete(self.url + "session.php", headers=self.headers, verify=self.verify)
        print(json.dumps(r.json()))


if __name__ == "__main__":
    usage = """Usage: atd_submit.py -i <ip> -u <username> -p <password> -f <filename> -a <profileid>"""
    title = 'McAfee ATD Python'
    parser = argparse.ArgumentParser(description=title)
    parser.add_argument('--atdip', '-i', required=True, type=str)
    parser.add_argument('--atdusername', '-u', required=True, type=str)
    parser.add_argument('--atdpassword', '-p', required=True, type=str)
    parser.add_argument('--atdprofileid', '-a', required=True, default=11, type=int)
    parser.add_argument('--file', '-f', required=True)

    args = parser.parse_args()

    atd = ATD()
    atd.sessionsetup()
    atd.submit_file()
    atd.logout()

