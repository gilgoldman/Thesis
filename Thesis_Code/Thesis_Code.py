import distTest # This imports distest for the distance measurement
import dht11
from flask import Flask, render_template # Web Framework
import numpy as np # For fancy math
import RPi.GPIO as GPIO # For RasPi Pin control
import sqlite3 # Database
import time # guess

app = Flask(__name__)

# Pin assignments:
# General pin assignments
# ERRORLED = 5

# For HC-sr04:
TRIG = 7
ECHO = 11


# Function definitions and calls:

# Retrieves Temperature and humidity from DHT11:
def temp():
    instance = dht11.DHT11(pin=7)
    result = instance.read()
    if result.is_valid():
        #A = "Temperature: %d C" % result.temperature # Is this line really relevant?
        #B = "Humidity: %d %%" % result.humidity # Is this line really relevant?

        # return ("Temperature: %d C" % result.temperature + "Humidity: %d %%" % result.humidity)
        # print """ Temperature: %d C Humidity: %d""" % (result.temperature, result.humidity)
        #return """Temperature: %d C <br/>Humidity: %d""" % (result.temperature, result.humidity)
        return (result.temperature, result.humidity)

# Retrieves distance from HC-sr04
def distance_read():
    return (distTest.main())


# Prepare board
GPIO.setmode(GPIO.BOARD)

# Pin Setup
#GPIO.setup(ERRORLED, GPIO.OUT) # Assigns an output pin For LED
GPIO.setup(TRIG, GPIO.OUT) # Sets the trig signal for hc-sr04 as output
GPIO.setup(ECHO, GPIO.IN) # Sets a pin for input for echo



# This is the main page - the on button and graphs will appear here
@app.route('/')
def index():

    return render_template('index.html')


@app.route('/distance_test')
def distance_test():
    float x = distance_read()
    return """ Distance: %d cm """ % (x)





if __name__ == '__main__':
	app.run(debug=True, host='0.0.0.0')
