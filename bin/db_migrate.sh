#!/usr/bin/env bash

QABOT="`pwd`/.."
PY3='/usr/bin/python3'
STEPS=2

echo "[Step: 1/${STEPS}] Django: makemigrations app"
$PY3 $QABOT/manage.py makemigrations app
echo "DONE!"
echo

echo "[Step: 2/${STEPS}] Django: migrate"
$PY3 $QABOT/manage.py migrate
echo "DONE!"
echo
