#!/usr/bin/env bash
# Download the appropriate Splunk RPM files.

# To update these commands to download newer Splunk releases, log into
# Splunk.com and vist the downloads page.

# From http://www.splunk.com/download
wget -O splunk-5.0.2-149561-linux-2.6-x86_64.rpm 'http://www.splunk.com/page/download_track?file=5.0.2/splunk/linux/splunk-5.0.2-149561-linux-2.6-x86_64.rpm&ac=storm_splunkdownload&wget=true&name=wget&typed=releases'

# From http://www.splunk.com/download/universalforwarder
wget -O splunkforwarder-5.0.2-149561-linux-2.6-x86_64.rpm 'http://www.splunk.com/page/download_track?file=5.0.2/universalforwarder/linux/splunkforwarder-5.0.2-149561-linux-2.6-x86_64.rpm&ac=storm_splunkdownload&wget=true&name=wget&typed=releases'
