#!/usr/bin/python

######################################################
############## CONFIGURATION #########################

location = 'SPXX0016' #  weather_id, default = Bilbao
d = 0

######################################################
######################################################

import pywapi # take weather information

info = pywapi.get_weather_from_yahoo(location, 'metric')
temp = info['condition']['temp']
sunrise = info['astronomy']['sunrise']
sunset  = info['astronomy']['sunset']
high = info['forecasts'][d]['high']
low = info['forecasts'][d]['low']
prev = info['forecasts'][d]['text']
print(" "+prev+" "+temp+"("+low+"-"+high+")  "+sunrise+"  "+sunset)
