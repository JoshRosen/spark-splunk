#!/usr/bin/env bash
# Installs Splunk on the Spark Master node.

# Install Splunk itself:
SPLUNK_RPM=`find splunk-*-linux-2.6-x86_64.rpm`
rpm -i $SPLUNK_RPM
SPLUNK="/opt/splunk/bin/splunk --accept-license"

# Store the Splunk database on an ephemeral local disk:
echo "SPLUNK_DB=/mnt/splunk_db" >> /opt/splunk/etc/splunk-launch.conf

# Install the Spark Splunk App:
cp -r ./spark_app /opt/splunk/etc/apps/spark

# Symlink that app into `deployment_apps` so that it's deployed to the workers:
ln -s /opt/splunk/etc/apps/spark /opt/splunk/etc/deployment-apps/spark

# Configure the deployment server:
echo "
# Example 1
# Matches all clients and includes all apps in the server class

[global]
whitelist.0=*
# whitelist matches all clients.
[serverClass:AllApps]
disabled = 0
whitelist.0 = *
[serverClass:AllApps:app:*]
# a server class that encapsulates all apps in the repositoryLocation
disabled = 0
whitelist.0 = *
" > /opt/splunk/etc/system/local/serverclass.conf

# On most Spark EC2 nodes, there's very little free disk space on the boot
# volume.  There's probably a better workaround than this:
$SPLUNK set minfreemb 1000

# Start Splunk
$SPLUNK start

# Enable the deployment server, allowing this Splunk instance to push
# applications and configuration updates to the Universal Forwarders running on
# the worker machines:
$SPLUNK enable deploy-server -auth admin:changeme

# Listen for data forwarded from the workers:
$SPLUNK enable listen -port 9997 -auth admin:changeme

# Restart Splunk and reload the deployment server
$SPLUNK restart
$SPLUNK reload deploy-server -class AllApps -auth admin:changeme
