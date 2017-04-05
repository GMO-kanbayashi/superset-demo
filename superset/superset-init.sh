#!/bin/bash

set -eo pipefail

if [ ! -f $SUPERSET_HOME/superset_config.py ]; then
  touch $SUPERSET_HOME/superset_config.py

  cat > $SUPERSET_HOME/superset_config.py <<EOF
import os
from flask_appbuilder.security.manager import AUTH_OAUTH
basedir = os.path.abspath(os.path.dirname(__file__))

AUTH_TYPE = AUTH_OAUTH

OAUTH_PROVIDERS = [
    {'name':'google', 'icon':'fa-google', 'token_key':'access_token',
        'remote_app': {
            'consumer_key':'{GOOGLE_AUTH_CLIENT_ID}',
            'consumer_secret':'{GOOGLE_AUTH_SECRET_KEY}',
            'base_url':'https://www.googleapis.com/plus/v1/',
            'request_token_params':{
              'scope': 'https://www.googleapis.com/auth/userinfo.email'
            },
            'request_token_url':None,
            'access_token_url':'https://accounts.google.com/o/oauth2/token',
            'authorize_url':'https://accounts.google.com/o/oauth2/auth'}
    }
]

SQLALCHEMY_DATABASE_URI = '${SUPERSET_DB_URI}'
SUPERSET_WEBSERVER_PORT = 8088
EOF
fi

sleep 20

if [ ! -f $SUPERSET_HOME/.setup-complete ]; then

  fabmanager create-admin --app superset --username $ADMIN_USERNAME --firstname $ADMIN_FIRST_NAME --lastname $ADMIN_LAST_NAME --email $ADMIN_EMAIL --password $ADMIN_PWD

  superset db upgrade

  superset init

  touch $SUPERSET_HOME/.setup-complete
else
  superset db upgrade
fi

superset runserver -d  -p 8088 -a 0.0.0.0
