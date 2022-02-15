#import datetime class from datetime module , requests(http libraby),json, socket(enable programs to send and receive data)
from datetime import datetime
import requests
import json
import socket

#get the running docker host name and ip address
hostname = socket.gethostname()
IPAddr = socket.gethostbyname(hostname)

#create function to return a json with time and container details
def return_time():
    
    #get the local time in the machine
    now = datetime.now()
    local_time = now.strftime("%H:%M:%S")

    url = 'http://worldtimeapi.org/api/timezone/Asia/Colombo'
    response = requests.get(url)
    json_data = response.text
    x = json.loads(json_data)
    date_time = x["datetime"]
    y = (date_time.split("T")[1])
    current_time = y.split(".")[0]

    #creating a dictionary
    z = {
        "Local Server Time "  : local_time,
        "Current Time" : current_time,
        "Server Name" : hostname,
        "IP Address" : IPAddr
    }

    #convert dictionary to a json
    json_array = json.dumps(z)

    return json_array


