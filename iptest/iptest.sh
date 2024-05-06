#!/bin/bash

git pull

cat /dev/null > cfproxy.txt

# 筛选HK IP
./CloudflareST -f ip_hk.txt -tl 250 -sl 5 -url https://speedtest.venusir.com

awk -F "," 'NR!=1{print $1}' result.csv > tmp.txt

sed "s/$/:443#HK/g" tmp.txt >> cfproxy.txt

# 筛选CN IP
./CloudflareST -f ip_cn.txt -tl 250 -sl 5 -url https://speedtest.venusir.com

awk -F "," 'NR!=1{print $1}' result.csv > tmp.txt

sed "s/$/:443#CN/g" tmp.txt >> cfproxy.txt

rm -rf tmp.txt

git add .

git commit . -m 每日更新优选IP

git push