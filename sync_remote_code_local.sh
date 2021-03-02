#!/bin/bash

echo -e "\033[31m $(date) \033[0m"

# 目标ip地址
ip_addr=""
# 用户名称
user_name=""
# 路径
parent_path=""
# 目录名称
name=""

while getopts ":i:u:p:n:h:" opt; do
  case $opt in
  i)
    echo -e "\033[34m ip地址: $OPTARG \033[0m"
    ip_addr=$OPTARG
    ;;
  p)
    echo -e "\033[34m 父目录: $OPTARG \033[0m"
    parent_path=$OPTARG
    ;;
  n)
    echo -e "\033[34m 目录名称: $OPTARG \033[0m"
    name=$OPTARG
    ;;
  u)
    echo -e "\033[34m ssh的用户名: $OPTARG \033[0m"
    user_name=$OPTARG
    ;;
  h)
    echo -e "\033[34m 命令描述：-i :ip地址 \n -p 需要同步的目录的父目录绝对路径 \n -n 需要同步的目录名称 \n -u ssh的用户名 \033[0m"
    exit
    ;;
  ?)
    echo -e "\033[31m 未知参数 \033[0m"
    exit 1
    ;;
  esac
done

local_object="./$name"

echo -e "\033[34m 准备删除本地已存在数据 \033[0m"

rm -rf $local_object

echo -e "\033[34m 本地数据删除操作执行完成 \033[0m"

ssh_path="${user_name}@${ip_addr}"

echo -e "\033[34m 执行远程压缩开始 \033[0m"
ssh -t -p 22 $ssh_path "cd ${parent_path}; zip -1 -r -q  ${name}.zip ./${name}"
echo -e "\033[34m 执行远程压缩完成 \033[0m"

scp_code="${ssh_path}:${parent_path}/${name}.zip"

scp -P 22 $scp_code ./

unzip ./${name}.zip

exit
