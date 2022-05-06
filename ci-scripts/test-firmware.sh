#!/bin/bash
usbhub --disable-i2c --hub 624C power state --port 1 --reset
sleep 1s
source testing-venv/bin/activate
cd firmware
make installRfCatYS1CCBootloader
cd ..
deactivate