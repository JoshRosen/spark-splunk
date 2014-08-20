#!/usr/bin/env bash
# Installs Splunk Universal Forwarders on the Spark Worker nodes.

# Copy the RPM to the workers
SPLUNK_FORWARDER_RPM=`find splunkforwarder-*-linux-2.6-x86_64.rpm`
WORKER_RPM_PATH=/tmp/splunk-forwarder.rpm
cp $SPLUNK_FORWARDER_RPM $WORKER_RPM_PATH
~/spark-ec2/copy-dir $WORKER_RPM_PATH

# The address of this machine, used to configure the forwarders:
HOSTNAME=`ec2-metadata --local-ipv4 | cut -d: -f2 | tr -d ' '`
DEPLOY_SERVER=$HOSTNAME:8089
FORWARD_SERVER=$HOSTNAME:9997

REMOTE_SCRIPT="
rpm -i \"$WORKER_RPM_PATH\"
rm -f \"$WORKER_RPM_PATH\"
# Start Splunk
/opt/splunkforwarder/bin/splunk --accept-license start --answer-yes --auto-ports --no-prompt
# Configure it to use the deploy and forward servers on the Spark master
/opt/splunkforwarder/bin/splunk --accept-license set deploy-poll \"$DEPLOY_SERVER\" --accept-license --answer-yes --auto-ports --no-prompt  -auth admin:changeme
/opt/splunkforwarder/bin/splunk --accept-license add forward-server \"$FORWARD_SERVER\" -auth admin:changeme
/opt/splunkforwarder/bin/splunk restart
"

# Install pssh:
yum -y install pssh

# Run the install script on each worker:
pssh -i -h /root/spark-ec2/slaves "$REMOTE_SCRIPT"
