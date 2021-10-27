import urllib.request, json 
from datetime import datetime, timedelta
import time

template = "https://www.mvg.de/api/fahrinfo/routing/?fromStation=de:09184:490&toStation=de:09162:34&time={0}&sapTickets=true&transportTypeCallTaxi=true"


url = template.format(int(time.time()) * 1000)

with urllib.request.urlopen(url) as request:
    data = json.loads(request.read().decode())
    result = []

    connections = data['connectionList']
    for connection in connections:
        departure_unix = connection['departure']
        departure = datetime.utcfromtimestamp(int(departure_unix) / 1000)
        departure_time = departure + timedelta(hours=2)
        until_departure = departure_time - datetime.fromtimestamp(time.time())
        until_departure_mins = until_departure.seconds // 60
        result.append(str(until_departure_mins))
        #  print(departure_time.strftime('%H:%M'))

    print('train in ' + ', '.join(result[:3]) + ' min')
