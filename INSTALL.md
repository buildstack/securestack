![alt text](https://cdn-images-1.medium.com/max/800/1*LEhyNwN6QMjflc_BtHvTMw.png "SecureStack")

# Welcome to SecureStack! #
SecureStack is a drop in security layer for all your IT infrastructure.  Think of us as a "Platform-Security-as-a-Service".  SecureStack comes in two forms:  SecureStack Base and SecureStack Server.  You can find both products here in the AWS [Marketplace](https://aws.amazon.com/marketplace/seller-profile?id=040c3d94-af50-430e-85a0-03719a4f9fad "AWS Marketplace")

## Install the SecureStack Agent ##

### CentOS 7 Agent Install ###

1. ssh to the server and become root equivalent

2. Install wget: ```yum install -y wget```

3. Install the RPM: ```rpm -ivh https://s3-ap-southeast-2.amazonaws.com/securestack-download/securestack-centos7-agent-2.0.1-1.el7.x86_64.rpm```

### Ubuntu 16.04 (Xenial) Agent Install ###

1. Download the agent package: ```wget https://s3-ap-southeast-2.amazonaws.com/securestack-download/securestack-ubuntu-agent_2.0.1-1xenial_amd64.deb```

2. Install the deb file: ```sudo apt install ./securestack-ubuntu-agent_2.0.1-1xenial_amd64.deb```

### Configure OSSEC ###

1. Set the server value in /var/ossec/etc/ossec.conf. Replace <sipserver_ip> below with the IP address of your existing SIPServer:

```sed -i 's/MANAGER_IP/<sipserver_ip>/g' /var/ossec/etc/ossec.conf``` 

2. Configure OSSEC to use tcp:

```sed -i 's/udp/tcp/g' /var/ossec/etc/ossec.conf```

3. Get the authd password on the SIPServer and use it on the server you are trying to add:

```/var/ossec/bin/agent-auth -m <sipserver_ip> -P<authd_password>```

4. Finally, restart the client OSSEC agent. Replace the <sipserver_ip> and <authd_password> below with the correct values:

```/var/ossec/bin/agent-auth -m <sipserver_ip> -P<authd_password>```

### Configure OSSEC ###

1. You should now be able to see the new server as active on the SIPServer.  Run this command as the securestack user on the SIPServer, not the server you just added:

```/opt/securestack/scripts/securestack agent list```

2. Go to your SIEM and you should now see security data from your new server.

