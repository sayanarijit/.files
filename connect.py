import pyautogui
import time


X, Y = pyautogui.size()
pyautogui.moveTo(497,1010, duration=.5)
pyautogui.click()
time.sleep(5)
pyautogui.moveTo(589,642, duration=.5)
pyautogui.click()
time.sleep(5)
pyautogui.moveTo(570,336, duration=.5)
pyautogui.click()
pyautogui.typewrite("https://#####") # VPN URL
pyautogui.moveTo(830,336, duration=.5)
pyautogui.click()
time.sleep(5)
pyautogui.moveTo(570,430, duration=.5)
pyautogui.click()
pyautogui.typewrite("#####") # Username
pyautogui.moveTo(570,460, duration=.5)
pyautogui.click()
pyautogui.typewrite("#####") # Password
pyautogui.moveTo(570,500, duration=.5)
pyautogui.click()
time.sleep(25)
pyautogui.moveTo(618,608, duration=.5)
pyautogui.click()
