const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

const urlFilePath = path.resolve(__dirname, 'captive_portal_url.txt');

// Function to get the current timestamp
function getCurrentTimestamp() {
  return new Date().toISOString();
}

(async () => {
  // Launch a new browser instance in headless mode with a custom user data directory
  const browser = await puppeteer.launch({
    headless: true,
    executablePath: '/usr/bin/chromium-browser', // Path to the Chromium executable
    args: [
      '--no-sandbox',
      '--disable-setuid-sandbox',
      '--user-data-dir=/home/pi/cfe/puppeteer-data-dir' // Custom user data directory
    ]
  });
  const page = await browser.newPage();

  // Navigate to a known URL to trigger the captive portal redirection
  const knownUrl = 'http://example.com';
  await page.goto(knownUrl);

  // Wait for the redirection to the captive portal
  await page.waitForNavigation({ waitUntil: 'networkidle0' });

  // Get the redirected URL (captive portal URL)
  const loginUrl = page.url();
  console.log(`[${getCurrentTimestamp()}] Detected captive portal URL: ${loginUrl}`);

  // Save the URL to a file
  fs.writeFileSync(urlFilePath, loginUrl);

  // Navigate to the captive portal login URL
  await page.goto(loginUrl);

  // Wait for the label associated with the checkbox to be present and visible
  await page.waitForSelector('label[for="option-aceptar"]', { visible: true });

  // Ensure the label is clickable
  const label = await page.$('label[for="option-aceptar"]');
  const isLabelClickable = await label.boundingBox();
  if (isLabelClickable) {
    await label.click();
  } else {
    throw new Error('Label is not clickable');
  }

  // Wait for the button to be enabled and visible
  await page.waitForSelector('#annoyBtn:not([disabled])', { visible: true });

  console.log(`[${getCurrentTimestamp()}] Login successful!`);

  // Close the browser instance
  await browser.close();
})();