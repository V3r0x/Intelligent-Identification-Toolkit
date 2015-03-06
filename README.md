# Intelligent-Identification-Toolkit

Intelligent Identification Toolkit is a QR Code Scanner that displays data to a scanned stable URI of non-information resource objects. It basically connects non-information objects like 3D printed products with (meta) information. It follows the rules of the Semantic Web (by Tim Berners Lee). Products can be enhanced with QR Code to link them to information. Not yet existing products e.g. 3D printable products can inhert an QR Code on their surface and can be linked to meta information.

### Hardware Software Requirements
- Raspberry Pi (NOOBS, or Raspbian OS)
- SD Card
- Micro usb power supply: 1-1.2 A & 5V 
- PiFace Camera or C270 Logitech Webcam or different working Webcam
- Mouse & Keyboard (or SSH connection / Tightvnc) (enable SSH with sudo rasp-config in Advanced settings options)
- WinSCP for SFTP file transfer to RPi (IP, Port 22, user: pi pw raspberry)
- HDMI Cable / Display
- R45 LAN Cable or WIfi Stick
- LAMP Stack (Linux, Apache2, MySQL, phpmyadmin)

Explanation: $ are shell commands; you can leave out the sudo command when you type in $sudo bash ,then the shell has sudo rights all the time.
But remember: >>With great power, comes great responsibility<< - Uncle Ben (Spiderman)


1. Install NOOBs or Raspbian on your Raspberry Pi
```sh
$sudo apt-get update
$sudo apt-get dist-upgrade
```

### Install LAMP Stack:
```sh
$sudo apt-get install php5 libapache2-mod-php5
$sudo service restart apache2
$sudo apt-get install mysql-server
$sudo apt-get install phpmyadmin
$sudo php5enmod mcrypt
$sudo service apache2 restart
$sudo nano /etc/apache2/apache2.conf new line "Include /etc/phpmyadmin/apache.conf" (< or apache2.conf ?????)
$sudo service apache2 restart
$sudo install vsftpd  (FTP Service)
$sudo service vsftpd restart
```
See if it's working: localhost/phpmyadmin in Browser, also maybe test php with <?php phpinfo() ?> in a .php file

go to /var/www folder: 
```sh 
$cd /var/www/
```

### Change rights vor Webfile folder

$sudo groupadd www-data (new group www-data)
$sudo adduser pi www-data (add pi user to the webfolder group)
$sudo chgrp www-data /var/www (set rights for folder)
$sudo chmod g+w /var/wwww (set read write rights for group in the /var/www/ folder)

check rights in /var/www/ folder: 
```sh 
$ls -al
```

me personally has the settings different for editing with the pi user and more liberal rights for developing (777)

possible solutions:
```sh 
$sudo chown -R pi /var/www/
$sudo chmod 777 /var/www/
$chown -R www-data:www-data /var/www
```




### Installation of Zbarcam / QR Code / Barcode reader

1. sudo apt-get install python-imaging zbar-tools qrencode
2. $zbarcam /dev/video0 (you can pipe the output into a text file with zbarcam /dev/video0 > file.txt)
3. QR Code generator: for example here: http://www.qrcode-generator.de/ for testing purposes


### Install application

1. Rename htaccess to .htaccess place it in the installation folder (web root) (not visible under Linux - just with $ls -a)
2. Import database.sql to your database via phpmyadmin this will install the tables
3. Write password , database name and username into script.php for DB access
5. change the monitoring txt file (cam.txt) to the document you want in the index.php and get.php files. (cam.txt as default)
6. Allow URL Override in Apache2 conf.d. Search for /etc/apache2/sites-available/ for a "conf" file. Edit with $sudo nano /etc/apache2/sites-available/ and change the according line "Allow Override None" to "Allow Override All" or just move or copy the provided file to the according folder (sudo cp filesource filetarget) that is provided.
7. type in shell command: $sudo a2enmod rewrite; afterwards: $sudo service apache2 restart
8. generate QR Code / Barcodes
9. To run the code place the files in a folder on your server. If the url to your server is
 http://abc.com/ the products can be accessed via http://abc.com/product/productname. With changed .htaccess file also with folders possible ip/product/productname Productnames are in the database the "link" field. So when there is specified "car" in the link field of products table, then the url url/product/car points there and displays the information and updates automatically on a change / new input in the txt file.

ATTENTION:
The script only functions in the root folder now: localhost (/index.php)or IP of RPi (or if product url set in localhost/product/ (index.php)



### Hint section
- check apache2 log for errors (in case): $cat /var/log/apache2/errorlog
- kill processes: e.g. video camera $lsof /dev/video; kill -9 id (of process)
- create shortcut for user pi's home folder to the web root folder $ln -s /var/www ~/www 
- let Apache2 run as current user (e.g. pi) $sudo nano /etc/apache2/envvars edit lines:
export APACHE_RUN_USER=www-data <- change to pi
export APACHE_RUN_GROUP=www-data <- also change to pi if you want

- check for USB applicances: $lsusb
- check for internet connectivity: ifconfig
- Edimax Wlan Stick deactivate power safing mode: sudo nano /etc/modprobe.d/8192cu.conf add line to empty file (without ""): "options 8192cu rtw_power_mgnt=0 rtw_enusbss=0"
-  on FullHD displays RaspberryPi could have black bars: check Overscan settings: $sudo nano /boot/config.txt set line disable_overscan=0 to 1; oder adjust the overscan values to left=24;right=24;top16;bottom=16; also hdmi_mode=0 could be set to 1.