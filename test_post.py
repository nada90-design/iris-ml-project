import json
from urllib.request import Request, urlopen

measurements = {
    'sepal_length': 5.1,
    'sepal_width': 3.5,
    'petal_length': 1.4,
    'petal_width': 0.2
}

payload = json.dumps(measurements).encode('utf-8')
req = Request(
    'http://127.0.0.1:5000/predict',
    data=payload,
    headers={'Content-Type': 'application/json'},
    method='POST'
)

with urlopen(req) as reply:
    print(reply.status)
    print(reply.read().decode('utf-8'))