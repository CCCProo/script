from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

import time

asset_id = 0
url = f"https://www.roblox.com/catalog/{asset_id}/"


cookies = []
with open("cookies.txt", "r", encoding="utf-8") as file:
    cookies = [line.strip() for line in file if line.strip()]

options = webdriver.ChromeOptions()
options.add_argument("--headless")
options.add_argument("--disable-gpu")
options.add_argument("--log-level=3")
options.add_argument("--start-maximized")


driver = webdriver.Chrome(options=options)

try:
    for cookie_value in cookies:
        
        driver.get(url)
        driver.add_cookie({
            'name': '.ROBLOSECURITY',
            'value': cookie_value,
            'domain': '.roblox.com',
            'path': '/',
            'httpOnly': True,
            'secure': True,
        })

        driver.refresh()

        wait = WebDriverWait(driver, 3)
        try:
            favorite_icon = wait.until(EC.presence_of_element_located((By.ID, "favorite-icon")))
            
            if "favorited" not in favorite_icon.get_attribute("class"):
                favorite_button = wait.until(EC.element_to_be_clickable((By.ID, "toggle-favorite")))
                favorite_button.click()

        except Exception as e:
            print(f"Error {e}")

        time.sleep(1) 

except Exception as e:
    print(f"Произошла ошибка: {e}")

finally:
    driver.quit()
