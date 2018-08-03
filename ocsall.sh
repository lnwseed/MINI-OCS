#!/bin/bash
cd
sudo apt-get update
apt-get remove apt-listchanges
apt-get install curl
sudo apt install curl
sudo apt-get update
sudo apt-get install curl
clear
echo "
----------------------------------------------
[√] ยินดีต้อนรับเข้าสู่ : ระบบสคริป Ocspanel.info 
[√] Connect...
[√] Wellcome : กรุณาทำตามขั้นตอน... [ OK !! ]
----------------------------------------------
 "
clear 
echo "
----------------------------------------------
[√] OCS PANELS INSTALLER FOR DEBIAN 
[√] DEVELOPED BY OCSPANEL.INFO
[√] ( 097-026-7262 )
----------------------------------------------
 "
clear
echo "
[√] ( กรุณายืนยันการตั้งค่าต่าง ๆ ดังนี้ )
[√] ( หากคุณไม่เห็นด้วยกับรหัสผ่านของเรา เพียงกด ลบ )
[√] ( หากต้อฃการทดลองเพียงแค่กด Enter ไป )
---------------------------------------------- 
 "
echo "1.ตั้งรหัสผ่านใหม่สำหรับ user root MySQL:"
read -p "Password baru: " -e -i abc12345 DatabasePass
echo "----------------------------------------------" | lolcat
echo "2.ตั้งค่าชื่อฐานข้อมูลสำหรับ OCS Panels"
echo "โปรดใช้ตัวอัพษรปกติเท่านั้นห้ามมีอักขระพิเศษอื่นๆที่ไม่ใช่ขีดล่าง (_)"
read -p "Nama Database: " -e -i OCS_PANEL DatabaseName
echo "----------------------------------------------" | lolcat
echo "เอาล่ะ [ พี่เทพ ] เราพร้อมที่จะติดตั้งแผง OCS ของคุณแล้ว"
read -n1 -r -p "กดปุ่ม Enter เพื่อดำเนินการต่อ ..."
apt-get remove --purge mysql\*
dpkg -l | grep -i mysql
apt-get clean
apt-get install -y libmysqlclient-dev mysql-client
service nginx stop
service php5-fpm stop
service php5-cli stop
apt-get -y --purge remove nginx php5-fpm php5-cli
apt-get update -y
apt-get install build-essential expect -y
apt-get install -y mysql-server
so1=$(expect -c "
spawn mysql_secure_installation; sleep 3
expect \"\";  sleep 3; send \"\r\"
expect \"\";  sleep 3; send \"Y\r\"
expect \"\";  sleep 3; send \"$DatabasePass\r\"
expect \"\";  sleep 3; send \"$DatabasePass\r\"
expect \"\";  sleep 3; send \"Y\r\"
expect \"\";  sleep 3; send \"Y\r\"
expect \"\";  sleep 3; send \"Y\r\"
expect \"\";  sleep 3; send \"Y\r\"
expect eof; ")
echo "$so1"
chown -R mysql:mysql /var/lib/mysql/
chmod -R 755 /var/lib/mysql/
apt-get install -y nginx php5 php5-fpm php5-cli php5-mysql php5-mcrypt
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/rasta-team/MyVPS/master/nginx.conf"
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/rasta-team/MyVPS/master/vps.conf"
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
mkdir -p /home/vps/public_html
useradd -m vps
mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
service php5-fpm restart
service nginx restart
apt-get -y install zip unzip
cd /home/vps/public_html
wget http://xn--l3clxf6cwbe0gd7j.com/panelocs.zip
mv panelocs.zip LTEOCS.zip
unzip LTEOCS.zip
rm -f LTEOCS.zip
rm -f index.html
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
so2=$(expect -c "
spawn mysql -u root -p; sleep 3
expect \"\";  sleep 3; send \"$DatabasePass\r\"
expect \"\";  sleep 3; send \"CREATE DATABASE IF NOT EXISTS $DatabaseName;EXIT;\r\"
expect eof; ")
echo "$so2"
#pass
chmod 777 /home/vps/public_html/application/controllers/topup/wallet/cookie.txt
chmod 777 /home/vps/public_html/application/config/database.php
chmod 755 /home/vps/public_html/application/controllers/topup/wallet/config.php
chmod 755 /home/vps/public_html/application/controllers/topup/wallet/manager/TrueWallet.php
chmod 755 /home/vps/public_html/application/controllers/topup/wallet/manager/Curl.php
chmod 755 /home/vps/public_html/topup/confirm.php
chmod 755 /home/vps/public_html/topup/get.php
chmod 755 /home/vps/public_html/topup/index.php
chmod 755 /home/vps/public_html/topup/input.php
clear
echo ""
echo "Database:"
echo "- Database Host: localhost"
echo "- Database Name: $DatabaseName"
echo "- Database User: root"
echo "- Database Pass: $DatabasePass"
echo "----------------------------------------------"
echo "Admin Login:"
echo "- Username: ตามที่[พี่เทพ]ต้องการ"
echo "- Password New: ตามที่[พี่เทพ]ต้องการ"
echo "- Confirm Password New: ตามที่[พี่เทพ]ต้องการ"
echo "
----------------------------------------------
[√] นำข้อมูลไปติดตั้งที่ Browser ให้เสร็จสิ้น
[√] จากนั้นปิด Browser และกลับมาที่นี่ (Putty)
[√] แล้วกด [ENTER] !
----------------------------------------------
 " | lolcat
echo ""
read -p "หาก [ พี่เทพ ] มั่นใขว่าขั้นตอนข้างต้นได้ทำเสร็จแล้วโปรดกดปุ่ม [Enter] เพื่อดำเนินการต่อ ..."
echo ""
cd /root
apt-get update
service webmin restart
apt-get -y --force-yes -f install libxml-parser-perl
echo "unset HISTFILE" >> /etc/profile
sleep 2
cd /home/vps/public_html/
rm -rf install
sudo apt-get install curl
sudo service apache2 restart
sudo apt-get install php5-curl
sudo service apache2 restart
sleep 4
clear
echo "
----------------------------------------------
[√] กรุณาเข้าสู่ระบบ OCS Panel
[√] ที่ http://$MYIP:81/
[√] ขอบคุณที่ใช้บริการ Ocspanel.info <3
----------------------------------------------
 " | lolcat
rm -f /root/ocsall.sh
cd ~/
