#!/bin/bash
service=write_time.service; systemctl stop $service && systemctl disable $service && rm /etc/systemd/system/$service &&  systemctl daemon-reload && systemctl reset-failed
