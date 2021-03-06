#!/bin/sh

DATE_H=`date +%Y%m%d-%H`
NEW_RG_NAME="westus-${DATE_H}-rg"
TEMPLATE_FILE=/home/akira/techsummit/techsummit2018/centloop.json

FLG=`az group list --output table | awk '{ print $1 }' | grep ${NEW_RG_NAME}`

if [ "${FLG}" != "" ]
then
	echo "${NEW_RG_NAME} was already created"
	exit
fi
#echo ${NEW_RG_NAME}
echo ">>> az group create -n ${NEW_RG_NAME} --location westus"
read a
# creating new resource-group
az group create -n ${NEW_RG_NAME} --location westus --output table

echo ""
echo ">>> az group deployment validate -g ${NEW_RG_NAME} --template-file ${TEMPLATE_FILE} --output table"
read a
# validate your template and resource-group

if [ ! -s ${TEMPLATE_FILE} ]
then
	echo "not found ${TEMPLATE_FILE}"
	exit
fi

az group deployment validate -g ${NEW_RG_NAME} --template-file ${TEMPLATE_FILE} --output table
echo ""
echo ">>> az group deployment create -g ${NEW_RG_NAME} --template-file ${TEMPLATE_FILE} --output table"
read a
echo ""
# executing template depoloyment
az group deployment create -g ${NEW_RG_NAME} --template-file ${TEMPLATE_FILE} --output table
