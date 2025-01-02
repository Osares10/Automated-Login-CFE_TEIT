#!/bin/sh

attempt=0 # Initialize the attempt counter
max_attempts=5 # Set the maximum number of attempts
delay=30 # Set the delay between attempts in seconds

echo "$(date '+%Y-%m-%d %H:%M:%S') Starting login attempts..."

while [ $attempt -lt $max_attempts ]; do
  response=$( # Replace the following curl command with the one you captured from the browser
    curl -s 'https://acs.cfeteit.net:19008/portalauth/login' \
    -H 'Accept: application/json, text/javascript, */*; q=0.01' \
    -H 'Accept-Language: es-419,es;q=0.9' \
    -H 'Cache-Control: no-cache' \
    -H 'Connection: keep-alive' \
    -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
    -H 'Origin: https://acs.cfeteit.net:19008' \
    -H 'Pragma: no-cache' \
    -H 'Referer: https://acs.cfeteit.net:19008/portalpage/435dc728e5eb446aac41b5feee0acb44/20231108192230/pc/auth.html?apmac=c8b6d3b90460&uaddress=10.1.1.27&umac=6083e73b8cf7&authType=2&lang=en_US&ssid=Q0ZFIEludGVybmV0&pushPageId=509759ea-fa17-438f-9cf7-34b82401c9a4' \
    -H 'Sec-Fetch-Dest: empty' \
    -H 'Sec-Fetch-Mode: cors' \
    -H 'Sec-Fetch-Site: same-origin' \
    -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36' \
    -H 'X-Requested-With: XMLHttpRequest' \
    -H 'X-XSRF-TOKEN: 529ba70983be7afe514bdb9efbe0c4540107430ae7d68666f1023eda3bbd7604' \
    -H 'sec-ch-ua: "Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"' \
    -H 'sec-ch-ua-mobile: ?0' \
    -H 'sec-ch-ua-platform: "Windows"' \
    --data-raw 'pushPageId=509759ea-fa17-438f-9cf7-34b82401c9a4&userPass=~anonymous&esn=&apmac=c8b6d3b90460&armac=&authType=2&ssid=Q0ZFIEludGVybmV0&uaddress=10.1.1.27&umac=6083e73b8cf7&businessType=&acip=&agreed=1&registerCode=&questions=&dynamicValidCode=&dynamicRSAToken=&userName=~anonymous'
    )

  success=$(echo "$response" | grep -o '"success":true')

  if [ "$success" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Login successful"
    exit 0
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S') Login failed, attempt $((attempt + 1))/$max_attempts"
    attempt=$((attempt + 1))
    sleep $delay
  fi
done

echo "$(date '+%Y-%m-%d %H:%M:%S') All attempts failed."
