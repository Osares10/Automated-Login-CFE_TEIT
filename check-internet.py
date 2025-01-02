import requests
import time
import os
from datetime import datetime

def get_current_timestamp():
    return datetime.now().strftime('%Y-%m-%d %H:%M:%S')

def check_internet():
    retries = 5
    count = 0
    url = "http://google.com" # or any other website

    print(f"[{get_current_timestamp()}] Checking internet connection...")

    while count < retries:
        try:
            response = requests.get(url, timeout=5)
            if response.status_code == 200:
                print(f"[{get_current_timestamp()}] The device is connected to the internet.")
                return True
        except requests.ConnectionError:
            print(f"[{get_current_timestamp()}] Attempt {count + 1} failed. Retrying...")
            count += 1
            time.sleep(30) # wait for 30 seconds before retrying

    print(f"[{get_current_timestamp()}] No internet connection after {retries} attempts, rebooting...")
    os.system('sudo reboot')
    return False

# Call the function
check_internet()