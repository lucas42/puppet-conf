#!/bin/sh
# set -e
# Returns the number of seconds until a certificate expires
# https://calomel.org/lets_encrypt_client.html

Hostname=$1

[ -z "$Hostname" ] && echo "No hostname specified" && exit 1
Expires=`echo | openssl s_client -connect localhost:443 -servername $Hostname 2>/dev/null | openssl x509 -noout -enddate | sed 's/.*=//' | date +'%s' -f -`

Now=`date +%s`

Diff=`expr $Expires - $Now`

echo $Diff
