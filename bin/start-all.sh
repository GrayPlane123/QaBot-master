#!/usr/bin/env bash

QABOT_HOME="`pwd`/.."
QASNAKE_HOME="${QABOT_HOME}/lib/QA-Snake/QA"
HUBOT_HOME="${QABOT_HOME}/lib/Hubot"
SH='/bin/bash'
PY2='/usr/bin/python2'
PY3='/usr/bin/python3'
STEPS=4

echo "[Step: 1/${STEPS}] starting QA-Snake on port 50001"
cd $QASNAKE_HOME
screen -dmS QASnake $PY2 server.py
echo "DONE!"
echo

echo "[Step: 2/${STEPS}] starting QaBot-Django on port 50000"
cd $QABOT_HOME
screen -dmS Django $PY3 manage.py runserver 50000
echo "DONE!"
echo

echo "[Step: 3/${STEPS}] starting Hubot with my wechat :)"
cd $HUBOT_HOME
screen -dmS Hubot $SH bin/hubot -n qabot -l / -a weixin
echo "DONE!"
echo

sleep 1
echo "[Step: 4/${STEPS}] screen -list"
screen -list
echo '####################################################'
echo "Witness the wonder if there are 3 screens alive! :)"
echo