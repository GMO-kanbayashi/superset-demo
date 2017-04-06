
# superset-demo

This repository contains demo using [Superset](https://github.com/airbnb/superset). After begging containers, you can try Superset right now.   

## List of changes configurations

- Authentication uses OAuth by Google APIs.
  - Prepare a client-id, secret-key from Google developer console, and to enable Google+ Api.
  - Set `Redirect URI` to `http://localhost:8088/oauth-authorized/google` at Google Developers Console.
- Database uses `mysql` that one of containers.

## How to start

### Step 1

Using following shell script, set up a google auth codes then starting containers.

```
./setup.sh <GOOGLE_AUTH_CLIENT_ID> <GOOGLE_AUTH_SECRET_KEY>
```

### Step2

After starting containers,  create a user of Superset who you want to login by using following docker command.

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