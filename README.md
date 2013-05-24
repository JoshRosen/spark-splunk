spark-splunk
============

This repository contains scripts for installing and configuring Splunk on clusters created using [spark-ec2](https://github.com/mesos/spark-ec2).

_Note:_ I'm a Splunk beginner, so this code may not be a good way to configure Splunk.
Patches are welcome!


Downloading Splunk
------------------
To use these scripts, you'll need to [download Splunk](http://www.splunk.com/download/) and the [Splunk Universal Forwarder](http://www.splunk.com/download/universalforwarder).
The `download_splunk_rpms.sh` script will download a recent version of Splunk.

Want to use a newer version?
The Splunk downloads page has a link that says "Using wget?  Get this URL."
You can use that command to download the packages directly to the Spark master machine.
Make sure to download the `linux-2.6-x86_64.rpm` packages.


Usage
-----

These scripts will install Splunk, configure [deployment](http://docs.splunk.com/Documentation/Splunk/latest/Deploy/Aboutdeploymentserver) and [forwarding](http://docs.splunk.com/Documentation/Splunk/latest/Deploy/Introducingtheuniversalforwarder), and install a Splunk app with some default settings for forwarding Spark's logs.

Run `install_master.sh` to set up Splunk on the Spark master node, then run `install_workers.sh` to install Splunk Universal Forwarders on the Spark worker nodes.
Make sure that the RPMs that you downloaded are in the same directory as these scripts.

Finally, you may need to restart everything before forwarding will work:

```bash
/opt/splunkforwarder/bin/splunk restart splunkd
pssh -h /root/spark/conf/slaves "/opt/splunkforwarder/bin/splunk restart splunkd"
```
