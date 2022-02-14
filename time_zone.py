#import datetime class from datetime module
from datetime import datetime
import requests
import json

def return_time():
    now = datetime.now()
    local_time = now.strftime("%H:%M:%S")

    url = 'http://worldtimeapi.org/api/timezone/Asia/Colombo'
    response = requests.get(url)
    json_data = response.text
    x = json.loads(json_data)
    date_time = x["datetime"]
    y = (date_time.split("T")[1])
    current_time = y.split(".")[0]

    z = {
        "local server time "  : local_time,
        "current time" : current_time 
    }

    json_array = json.dumps(z)

    return json_array


