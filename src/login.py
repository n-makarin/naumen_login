import yaml
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import webbrowser
import sys

login_details_path = sys.argv[1] + 'login_details.yml'

conf = yaml.safe_load(open(login_details_path))
myFbEmail = conf['user']['email']
myFbPassword = conf['user']['password']
url = conf['url']
driver = None

def set_driver():
   chrome_options = Options()
   chrome_options.add_experimental_option("debuggerAddress", "127.0.0.1:9222")
   chrome_driver = "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
   global driver
   driver = webdriver.Chrome(chrome_driver, options=chrome_options)

def login(driver, url, usernameId, username, passwordId, password, submit_buttonId):
   driver.switch_to.new_window('tab')
   driver.get(url)
   driver.find_element('id', usernameId).send_keys(username)
   driver.find_element('id', passwordId).send_keys(password)
   driver.find_element('id', submit_buttonId).click()
   driver.quit()

set_driver()
login(driver, url, "username", myFbEmail, "password", myFbPassword, "submit-button")