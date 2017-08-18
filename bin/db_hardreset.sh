#!/usr/bin/env bash

QABOT="`pwd`/.."
PY3='/usr/bin/python3'
STEPS=5

echo "[Step: 1/${STEPS}] Shell: rm db.sqlite3"
rm $QABOT/db.sqlite3
echo "DONE!"
echo

echo "[Step: 2/${STEPS}] Shell: rm -r /app/migrations"
rm -r $QABOT/app/migrations
echo "DONE!"
echo

echo "[Step: 3/${STEPS}] Django: makemigrations app"
$PY3 $QABOT/manage.py makemigrations app
echo "DONE!"
echo

echo "[Step: 4/${STEPS}] Django: migrate app"
$PY3 $QABOT/manage.py migrate app
echo "DONE!"
echo

echo "[Step: 5/${STEPS}] Dajngo: createsuperuser"
$PY3 $QABOT/manage.py createsuperuser --username qabot --email qabot@kahsolt.tk
echo "DONE!"
echo
