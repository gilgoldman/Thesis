import RPi.GPIO as GPIO
import time

LedPin = 5  #Pin number
def setup():
	GPIO.setmode(GPIO.BOARD)  # numbers GPIO by location
	GPIO.setup(LedPin, GPIO.OUT) # Set LedPin mode to output
	GPIO.output(LedPin, GPIO.HIGH)
	GPIO.setwarnings(False)


def blink():
    x = 0
    while x < 5:
        GPIO.output(LedPin, GPIO.HIGH)
        time.sleep(1)
        GPIO.output(LedPin, GPIO.LOW)
        time.sleep(1)
        x = x + 1
	
def destroy():
	GPIO.output(LedPin, GPIO.LOW)
	GPIO.cleanup()

if __name__ == '__main__':
	setup()
	try:
		blink()
	except KeyboardInterrupt:
		destroy()	
