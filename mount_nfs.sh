#!/bin/bash

ip_addr="192.168.71.71"

diskutil umount force /Users/ryanhuen/Work/NFS/xuanweihong 

sudo mount -t nfs -o resvport,rw,noatime ${ip_addr}:/home/xuanweihong /Users/ryanhuen/Work/NFS/xuanweihong
