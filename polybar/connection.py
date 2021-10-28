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
        if until_departure_mins < 100:
            result.append(until_departure_mins)

    print('Take U6 inbound in ' + ', '.join(map(str, list(sorted(result)[:4]))) + ' min')
