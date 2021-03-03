#!/bin/bash

ip_addr="192.168.71.71"

diskutil umount force /Users/liangruishuang/Work/NFS/xuanweihong 

sudo mount -t nfs -o resvport,rw  ${ip_addr}:/home/xuanweihong /Users/liangruishuang/Work/NFS/xuanweihong
