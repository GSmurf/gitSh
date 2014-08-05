#!/bin/bash

./sms.sh 'Je suis ton Raspberry Pi pres à servir ;)' &

./led.sh 0 1 0.1 1 0.1 1 0.1 1 0.1 1 0.1 &
./led.sh 1 0.2 0.4 1 0.4 1 0.4 2 0.1 &
./led.sh 2 0.3 0.3 0.3 0.3 0.3 3.3 0.5 0.2 &
