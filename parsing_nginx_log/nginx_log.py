#!/usr/bin/python

import re
import csv
import os.path

log_file='access.log'
csv_file='new_log.csv'


def creatcscfile(file):
   with open(file, 'w') as csvfile:
      fieldnames = [ 'detatime', 's-ip', 'cs-uri-query', 'sc-status' ]
      writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
      writer.writeheader()

def csvwriter(file, datetime, ip, query, status):
   with open(file, 'a') as csvfile:
      fieldnames = [ 'detatime', 's-ip', 'cs-uri-query', 'sc-status' ]
      writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
      writer.writerow({'detatime' : datetime,'s-ip': ip, 'cs-uri-query': query, 'sc-status' :status  })

print("Begin")

if (os.path.exists(log_file)):
   creatcscfile(csv_file)

   lineformat = re.compile(r"""(?P<ipaddress>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}) - - \[(?P<dateandtime>\d{2}\/[a-z]{3}\/\d{4}:\d{2}:\d{2}:\d{2} (\+|\-)\d{4})\] ((\"(GET|POST) )(?P<url>.+)(http\/1\.1")) (?P<statuscode>\d{3}) (?P<bytessent>\d+) (["](?P<refferer>(\-)|(.+))["]) (["](?P<useragent>.+)["])""", re.IGNORECASE)


   with open(log_file, 'r') as logfile:
      for line in logfile.readlines():
         data = re.search(lineformat, line)
         if data:
            datadict = data.groupdict()
            ip = datadict["ipaddress"]
            datetime = re.search(r'\d{2}\/\D{3}\/\d{4}:\d{2}:\d{2}:\d{2}', datadict["dateandtime"]).group(0)
            url = datadict["url"]
            bytessent = datadict["bytessent"]
            referrer = datadict["refferer"]
            useragent = datadict["useragent"]
            status = datadict["statuscode"]
            method = data.group(6)

         csvwriter( csv_file, datetime, ip, url, status)
else:
   print('the log file does not exist')
