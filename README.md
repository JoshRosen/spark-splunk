spark-splunk
============

This repository contains scripts for installing and configuring Splunk on clusters created using [spark-ec2](https://github.com/mesos/spark-ec2).

_Note:_ I'm a Splunk beginner, so this code may not be a good way to configure Splunk.
Patches are welcome!


Downloading Splunk
------------------
To use these scripts, you'll need to [download Splunk](http://www.splunk.com/download/) and the [Splunk Universal Forwarder](http://www.splunk.com/download/universalforwarder).
The `one_click_install.sh` and `download_splunk_rpms.sh` scripts will download a recent version of Splunk.

Want to use a newer version?
The Splunk downloads page has a link that says "Using wget?  Get this URL."
You can use that command to download the packages directly to the Spark master machine.
Make sure to download the `linux-2.6-x86_64.rpm` packages.

Opening ports in EC2 Security Groups
------------------------------------

By default, Splunk's web interface uses port 8000; you'll may have to open this port in the master's EC2 security group in order to access Splunk from your desktop.

You can open this port through the [AWS console](http://console.aws.amazon.com) or by using the [EC2 API Tools](http://aws.amazon.com/developertools/351):

```
ec2-authorize CLUSTERNAME-master -p 8000
```

where `CLUSTERNAME` is the cluster name in `spark-ec2`.


Installing and configuring Splunk
---------------------------------

These scripts will install Splunk, configure [deployment](http://docs.splunk.com/Documentation/Splunk/latest/Deploy/Aboutdeploymentserver) and [forwarding](http://docs.splunk.com/Documentation/Splunk/latest/Deploy/Introducingtheuniversalforwarder), and install a Splunk app with some default settings for forwarding Spark's logs.


__Quick Start__: Run `one_click_install.sh`.

__Alternative Instructions__:
Run `install_master.sh` to set up Splunk on the Spark master node, then run `install_workers.sh` to install Splunk Universal Forwarders on the Spark worker nodes.
Make sure that the RPMs that you downloaded are in the same directory as these scripts.

Finally, you may need to restart everything before forwarding will work:

```
/opt/splunk/bin/splunk restart splunkd
pssh -h /root/spark/conf/slaves "/opt/splunkforwarder/bin/splunk restart splunkd"
```

### Non-standard `SPARK_HOME`

If you're using a non-standard `SPARK_HOME`, you can edit `spark_app/default/inputs.conf` to add those log directories.

### Adding logs from the Spark driver

The app's default settings will consume Spark master and worker logs from their default locations on the Spark AMI.
Most of Spark's useful log messages appear in the driver's logs, so it's a good idea to add those logs to Splunk.
The easiest way to do this is to create a `log4j.properties` file for your application that appends the driver's log messages into a file, then add that file to Splunk via its web UI.
The [Quantifind blog](http://blog.quantifind.com/posts/logging-post/) has a good set of instructions for configuring Spark's logging.