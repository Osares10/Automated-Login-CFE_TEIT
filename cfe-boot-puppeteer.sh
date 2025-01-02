#!/bin/bash

# Navigate to the directory containing your Node.js script
cd /home/pi/cfe

# Deleting the puppeteer data directory
echo "Deleting the puppeteer data directory"

# Delete the puppeteer data directory
rm -rf /home/pi/cfe/puppeteer-data-dir

# Run the Node.js script
node cfe-boot.js

# Deleting the puppeteer data directory
echo "Deleting the puppeteer data directory"

# Delete the puppeteer data directory
rm -rf /home/pi/cfe/puppeteer-data-dir
