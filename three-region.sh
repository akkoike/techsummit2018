#!/bin/sh

DATE_H=`date +%Y%m%d-%H`
NEW_RG_NAME="southeastasia-${DATE_H}-rg"
NEW_RG_NAME2="uksouth-${DATE_H}-rg"
NEW_RG_NAME3="australiasoutheast-${DATE_H}-rg"
TEMPLATE_FILE=/home/akira/techsummit/techsummit2018/centloop.json

FLG=`az group list --output table | awk '{ print $1 }' | egrep '(${NEW_RG_NAME}|${NEW_RG_NAME2}|${NEW_RG_NAME3})'`

if [ "${FLG}" != "" ]
then
	echo "${NEW_RG_NAME} or ${NEW_RG_NAME2} or ${NEW_RG_NAME3} was already created"
	exit
fi
# start
echo ">>> az group create -n ${NEW_RG_NAME} --location southeastasia"
echo ">>> az group create -n ${NEW_RG_NAME2} --location uksouth"
echo ">>> az group create -n ${NEW_RG_NAME3} --location australiasoutheast"
read a
# creating new resource-group
az group create -n ${NEW_RG_NAME} --location southeastasia --output table
az group create -n ${NEW_RG_NAME2} --location uksouth --output table
az group create -n ${NEW_RG_NAME3} --location australiasoutheast --output table

echo ""
echo ">>> az group deployment create -g ${NEW_RG_NAME} --template-file ${TEMPLATE_FILE} --no-wait"
echo ">>> az group deployment create -g ${NEW_RG_NAME2} --template-file ${TEMPLATE_FILE} --no-wait"
echo ">>> az group deployment create -g ${NEW_RG_NAME3} --template-file ${TEMPLATE_FILE} --no-wait"
read a
echo ""
# executing template depoloyment
az group deployment create -g ${NEW_RG_NAME} --template-file ${TEMPLATE_FILE} --no-wait
az group deployment create -g ${NEW_RG_NAME2} --template-file ${TEMPLATE_FILE} --no-wait
az group deployment create -g ${NEW_RG_NAME3} --template-file ${TEMPLATE_FILE} --no-wait
