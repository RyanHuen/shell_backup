#!/bin/zsh

source ~/.zshrc
for i in {1..500}
do
echo "times: $i";
mc rback && sleep 1 && fs -a feeslego && as -r am start -W com.lixiang.car.apps.feeslego/com.lixiang.car.apps.feeslego.MainActivity
sleep 5;
done
