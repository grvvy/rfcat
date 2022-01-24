#!/bin/bash 
source testing-venv/bin/activate
python3 ci-scripts/check_dongle.py
EXIT_CODE="$?"
echo $EXIT_CODE
deactivate
if [ "$EXIT_CODE" == "0" ]
then
    echo "Host tool installation success! Exiting.."
    exit 0
elif [ "$EXIT_CODE" == "241" ]
then
    echo "No Dongle Found. Exiting.."
    exit $EXIT_CODE
elif [ "$EXIT_CODE" == "1" ]
then
    echo "Host tool installation failed! Exiting.."
    exit $EXIT_CODE
else
    echo "Unhandled error"
    exit $EXIT_CODE
fi