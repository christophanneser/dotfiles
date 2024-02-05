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
        transport_type = connection['connectionPartList'][0]['product']
        if transport_type != 'UBAHN':
            continue
        departure_unix = connection['departure']
        departure = datetime.utcfromtimestamp(int(departure_unix) / 1000)
        departure_time = departure + timedelta(hours=1)
        until_departure = departure_time - datetime.fromtimestamp(time.time())
        until_departure_mins = until_departure.seconds // 60
        if until_departure_mins <= 600:
            result.append(until_departure_mins)

    print('%{F#4d94ff}%{u#4d94ff}%{+u}U6 in ' + ', '.join(map(str, list(sorted(set(result))[:4]))) + ' min%{-u}%{F-}')
