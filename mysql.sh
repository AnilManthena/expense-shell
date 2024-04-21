#!/bin/bash

USERID=$(id -u)
TIMESTAP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2...$R FAILURE $N"
        exit 1
    else
        echo -e "$2...$G SUCCESS $N"
        }

if [ $USERID -ne 0 ]
then 
    echo "Please run this script with root access."
    exit 1
else
    exho "You are super user."
fi

dnf install mysql-server -y &>>$LOGFILE 
VALIDATE $? "Installing MySql Server"

systemctl enble mysqld &>>$LOGFILE
VALIDATE $? "Enabling mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting mysql server"

mysql_secure_Installation --set-root-pass ExpenceApp@1 &>>$LOGFILE
VALIDATE $? "Settingup root password"