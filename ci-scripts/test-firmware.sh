#!/bin/bash
sleep 1s
source testing-venv/bin/activate
cd firmware
make installRfCatYS1CCBootloader
cd ..
deactivate