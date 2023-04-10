#!/bin/bash

grep_params=""
grep_name=""

end=$#
all_input=$*
output="${all_input}"

grep_params=${output}
echo -e "\033[32m final params is ($grep_params) \033[0m"

echo -e "\033[32m loggrep ./ '${grep_params}' \033[0m"

loggrep -sl n -sf n -p "${grep_params}"
sleep 0.1
new_name="_${grep_params// /_}"
mv ./result.txt ../all$new_name.txt
echo -e "\033[32m mv ./result.txt ../all$new_name.txt \033[0m"
