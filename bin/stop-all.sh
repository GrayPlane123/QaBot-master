#!/usr/bin/env bash

STEPS=4

echo "[Step: 1/${STEPS}] stoping Hubot"
screen -S Hubot -X kill
echo "DONE!"
echo

echo "[Step: 2/${STEPS}] stoping QaBot-Django on port 50000"
screen -S Django -X kill
echo "DONE!"
echo

echo "[Step: 3/${STEPS}] stoping QA-Snake on port 50000"
screen -S QASnake -X kill
echo "DONE!"
echo

echo "[Step:4/${STEPS}] screen -list"
screen -list
echo '############################'
echo "Should be no screens now. :("
echo