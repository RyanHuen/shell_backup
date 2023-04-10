#!/bin/bash

grep_params=""
grep_name=""

end=$#
all_input=$*
output="${all_input}"

#process
process=(${output// / })
for ((i = 0; i < ${#process[@]}; i++)); do 
    grep_params="$grep_params| ${process[i]} "
    grep_name="${grep_name}_${process[i]}"
done
grep_params=${grep_params:1}
echo -e "\033[32m final params is ($grep_params) \033[0m"
echo -e "\033[32m final name is ($grep_name) \033[0m"

echo -e "\033[32m loggrep ./ '${grep_params}' \033[0m"

loggrep -sl n -sf n -p "${grep_params}"
sleep 0.1
mv ./result.txt ../all$grep_name.txt
echo -e "\033[32m mv ./result.txt ../all$grep_name.txt \033[0m"
