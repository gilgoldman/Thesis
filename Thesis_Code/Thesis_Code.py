import RPi.GPIO as GPIO # For RasPi Pin control
import sqlite3 # Database
from flask import Flask, render_template # Web Framework
import time # guess
import numpy as np # For fancy math

app = Flask(__name__)

# Pin assignments:
# for HC-sr04:
TRIG = 7
ECHO = 11

# Function assignments:

# Retrieves Temperature and humidity from DHT11:
def temp():
    instance = dht11.DHT11(pin=7)
    result = instance.read()
    if result.is_valid():
        A = "Temperature: %d C" % result.temperature # Is this line really relevant?
        B = "Humidity: %d %%" % result.humidity # Is this line really relevant?

        # return ("Temperature: %d C" % result.temperature + "Humidity: %d %%" % result.humidity)
        # print """ Temperature: %d C
        # Humidity: %d""" % (result.temperature, result.humidity)

        return """Temperature: %d C <br/>Humidity: %d""" % (result.temperature, result.humidity)

# Retrieves distance from HC-sr04




# This is the main page - the on button and graphs will appear here
@app.route('/')
def index():



    return render_template('index.html')


@app.route('/distance_test')
def distance_test():
    instance = dh1.DHT11




if __name__ == '__main__':
	app.run(debug=True, host='0.0.0.0')