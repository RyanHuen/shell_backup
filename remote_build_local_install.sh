#!/bin/bash

echo -e "\033[31m $(date) \033[0m"

# 需要安装
install=0
# clean编译
clean=0
# gradle工程路径
project_path=""
# output apk parent path
output_apk_parent_path=""
# output apk name
apk_name=""
# 目标ip地址
ip_addr=""
# 用户名称
user_name=""
#pkg name
pkg_name=""
# 启动命令
am_start=""

while getopts ":i:c:p:o:n:d:u:h:l:k:" opt; do
  case $opt in
  i)
    echo -e "\033[34m 需要安装: $OPTARG \033[0m"
    install=$OPTARG
    ;;
  c)
    echo -e "\033[34m clean编译: $OPTARG \033[0m"
    clean=$OPTARG
    ;;
  p)
    echo -e "\033[34m gradle工程路径: $OPTARG \033[0m"
    project_path=$OPTARG
    ;;
  o)
    echo -e "\033[34m output apk path: $OPTARG \033[0m"
    output_apk_parent_path=$OPTARG
    ;;
  n)
    echo -e "\033[34m output apk name: $OPTARG \033[0m"
    apk_name=$OPTARG
    ;;
  d)
    echo -e "\033[34m ip:  $OPTARG \033[0m"
    ip_addr=$OPTARG
    ;;
  u)
    echo -e "\033[34m user: $OPTARG \033[0m"
    user_name=$OPTARG
    ;;
  l)
    echo -e "\033[34m am_start: $OPTARG \033[0m"
    am_start=$OPTARG
    ;;
  k)
    echo -e "\033[34m pkg_name: $OPTARG \033[0m"
    pkg_name=$OPTARG
    ;;
  h)
    echo -e "\033[34m 命令描述：-i :需要安装 \n -c clean编译 \n -p gradle工程路径 \n -o output apk parent 路径 \n -n output apk name \n -d ssh ip地址 \n -u ssh用户名 \n -l am_start apk启动页 \n -k apk应用包名 \033[0m"
    exit
    ;;
  ?)
    echo -e "\033[31m 未知参数 \033[0m"
    exit 1
    ;;
  esac
done

echo -e "\033[34m 删除本地apk \033[0m"
rm_code="./${apk_name}"
rm $rm_code

ssh_path="${user_name}@${ip_addr}"

echo -e "\033[34m 执行远程编译 \033[0m"

build_code="cd ${project_path}"

if [[ "$clean" == 1 ]]; then
  build_code="${build_code} && ./gradlew clean"
fi

build_code="${build_code} && ./gradlew assembleDebug"

echo -e "\033[34m 执行远程编译: clean == $clean \033[0m"
ssh -t -p 22 $ssh_path "$build_code"

scp_code="${ssh_path}:${output_apk_parent_path}/${apk_name}"

scp -P 22 $scp_code ./

if [[ "$install" == 1 ]]; then
  adb shell am force-stop ${pkg_name}
  adb install -r "./${apk_name}"
  echo $am_start
  if [[ "$am_start" != "" ]]; then
    adb shell am start -n "${am_start}" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
  fi
else
  exit
fi

exit