import pyautogui
import time


X, Y = pyautogui.size()
pyautogui.moveTo(535, 1010, duration=.5)
pyautogui.click()
pyautogui.moveTo(660, 500, duration=.5)
pyautogui.click()
pyautogui.typewrite("AB00457494")
pyautogui.moveTo(635, 535, duration=.5)
pyautogui.click()
pyautogui.typewrite("*****")
pyautogui.moveTo(650, 580, duration=.5)
pyautogui.click()
