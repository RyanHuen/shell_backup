#!/bin/zsh

all_input=$*
output="${all_input}"

grep_params=${output}
echo -e "\033[32m cd $grep_params \033[0m"
cd $grep_params
