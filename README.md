
# superset-demo

This repository contains demo using [Superset](https://github.com/airbnb/superset). After begging containers, you can try Superset right now.   

This demo of Superset customizes authentication that by using OAuth to Access Google APIs. So you have to prepare a client-id, secret-key from Google developer console, and to enable Google+ Api.

## Other customizes

- Database uses `mysql` that one of containers.

## How to start

### Step 1

Set up a google auth codes, then starting containers.

```
./setup.sh <GOOGLE_AUTH_CLIENT_ID> <GOOGLE_AUTH_SECRET_KEY>
```

### Step2

After starting containers, create user of Superset who you want to login.

```
docker exec -it superset \
  fabmanager create-admin --app superset \
  --username '<UserName of Google Account>' \
  --firstname '<any first name>' \
  --lastname '<any last name>' \
  --email '<Mail Address of Google Account>' \
  --password '<any password>'
```

You have to set the username and mail address of Google Account.  
Actually while using OAuth, a password does not use in authentication.

### Step3

Finally navigate to `http://localhost:8088/login` and login by using the user of Google Account.

## Reference repository

Reference repository is [tylerFowler/docker-superset](https://github.com/tylerFowler/docker-superset). thanks for @tylerFowler.