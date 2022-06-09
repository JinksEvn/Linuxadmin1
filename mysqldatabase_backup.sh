#!/bin/bash

#To new folder in opt
mkdir /opt/backups

#To generate a backup
date=$(date '+%m-%d-%Y')
mysqldump -u root -pjinks wordpress > wordpress${date}.sql

#To zip
tar -cv wordpress${date}.sql > wordpress${date}.gz 