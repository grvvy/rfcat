#!/usr/bin/env python3

from multiprocessing import Process
from rflib.chipcon_usb import USBDongle

def check_dongle():
    device = USBDongle()
    device.ping()

dongle_proc = Process(target=check_dongle)
dongle_proc.start()
dongle_proc.join(timeout=5)

if dongle_proc.is_alive():
    dongle_proc.terminate()
    dongle_proc.join()

exit (dongle_proc.exitcode)