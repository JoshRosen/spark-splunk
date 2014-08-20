#!/usr/bin/env bash
# Download the appropriate Splunk RPM files.

# To update these commands to download newer Splunk releases, log into
# Splunk.com and vist the downloads page.

# From http://www.splunk.com/download
wget -O splunk-6.1.3-220630-linux-2.6-x86_64.rpm 'http://www.splunk.com/page/download_track?file=6.1.3/splunk/linux/splunk-6.1.3-220630-linux-2.6-x86_64.rpm&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=6.1.3&product=splunk&typed=release'


# From http://www.splunk.com/download/universalforwarder
wget -O splunkforwarder-6.1.3-220630-linux-2.6-x86_64.rpm 'http://www.splunk.com/page/download_track?file=6.1.3/universalforwarder/linux/splunkforwarder-6.1.3-220630-linux-2.6-x86_64.rpm&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=6.1.3&product=splunk&typed=release'
