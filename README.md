# devops-takehome
Simple flask + sqlalchemy app


## Install the app
```bash
git clone git@github.com:gaingroundspeed/devops-takehome.git
cd devops-takehome
virtualenv -p python3 .
source bin/activate
pip install -r requirements.txt
```

## Start the app
If you're using a local postgres db use the following to run the app.
```bash
DATABASE_URL='postgresql://postgres:postgres@localhost:5432/groundspeed_devops' python app.py
```

## Interact with the API
POST a message to the API:
```bash
curl -X POST http://127.0.0.1:5000/message -H "Content-Type: application/json" --data '{"message": "hi"}'
```

GET a message
```bash
curl http://127.0.0.1:5000/message/1
```

HEALTHCHECK
```bash
curl http://127.0.0.1:5000/healthcheck
```
