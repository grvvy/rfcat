#!/bin/bash
python3 -m venv testing-venv
source testing-venv/bin/activate
python3 setup.py install
deactivate