#!/bin/bash
source testing-venv/bin/activate
cd firmware
make installRfCatYS1CCBootloader
cd ..
deactivate