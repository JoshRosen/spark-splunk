#!/usr/bin/env bash

./download_splunk_rpms.sh
./install_master.sh
./install_workers.sh
/opt/splunk/bin/splunk restart splunkd
pssh -h /root/spark/conf/slaves "/opt/splunkforwarder/bin/splunk restart splunkd"
