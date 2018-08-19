![alt text](https://cdn-images-1.medium.com/max/800/1*LEhyNwN6QMjflc_BtHvTMw.png "SecureStack")

# Welcome to SecureStack! #
SecureStack is a drop in security layer for all your IT infrastructure.  Think of us as a "Platform-Security-as-a-Service".  SecureStack comes in two forms:  SecureStack Base and SecureStack Server.  You can find both products here in the AWS [Marketplace](https://aws.amazon.com/marketplace/seller-profile?id=040c3d94-af50-430e-85a0-03719a4f9fad "AWS Marketplace")

### SecureStack Base ###
SecureStack Base is intended to be the foundation you build all your AWS infrastrucuture with.  It is a hardened version of CentOS 7 and comes with many security applications baked right in.  So, if in the past you've used a Linux image from the AWS Marketplace, or a custom image you've built yourself you can replace it with our [SecureStack Base AMI](https://aws.amazon.com/marketplace/pp/B0777BXSLW/?ref=_ptnr_web_gh_readme_us "SecureStack Base AMI").  

SecureStack helps you meet your audit and compliance needs with multiple tools integrated into both Server and Base versions.  All SecureStack Base instances will report their compliance and audit data directly to their SecureStack Server controller.  SecureStack currently has modules for: PCI-DSS, OWASP, SCAP, and CIS.   

### SecureStack SIPServer ###
SecureStack Security Intelligence Platform Server (SIPS) is your central management system that ties all your Base machines together.  SecureStack Server is a log collection, aggregation and analysis solution.  It's also a complete SIEM solution with real-time dashboards, custom visualizations and dashboards, event correlation, history and backup.  SecureStack Base instances talk to a SecureStack Server instance via an encrypted connection.  Events are passed in real-time so if an instance is compromised a hacker can't edit their history and make it disappear.  SecureStack Server already has the message and has alerted you to their presence.  SecureStack Server supports active response too.  If it sees an attack it can mitigate it with an automated response.  SecureStack Server also supports scheduled compliance checks.  Currently there are modules for: PCI-DSS, OWASP, SCAP, and CIS.   

### SecureStack Components ###
All versions of SecureStack come with:

* Intrusion detection and prevention
* Anti-virus
* Anti-malware
* Rootkit detection
* File integrity monitoring
* DDoS protection
* System auditing
* Web Application Firewall (WAF)
* Hardened Linux operating system

SecureStack Server also has:
* Security information and event management (SIEM)
* Cloud auditing
* Distributed firewall
* Security vulnerability scanning
* Compliance reports
* Visualizations and dashboards
* Event correlation and reports
* System monitoring (cpu, disk, io, network, etc)

### Initial Installation ###

You can find the latest [Installation and User Guide published as a Google document](https://docs.google.com/presentation/d/1WY1XRK3NKQes7gHf2NCZsnNvTXytBfuYj3ksJWE7cDQ/edit?usp=sharing "SecureStack Installation and User Guide")  After you've launched a SecureStack Base or Server instance you can ssh into it with the username securestack and the ssh key you provided. The first thing you will want to do is update the SecureStack sofware and operating system.

To update all versions of SecureStack run this from the command line:

```/opt/securestack/scripts/securestack update```

This command updates the CentOS operating system so occasionally you will have to run the update twice and reboot if there are any significant updates that require it.  The updater will let you know if you need to reboot.  When your system is done upgrading it will let you know by returning a 'Your operating system is up to date' message.  If you see this message you are safe to run the configuration next.

#### AWS: S3, and IAM ####

If you are going to run SecureStack workloads in AWS there are a couple things you can do to optimize your configuration.  These steps are not strictly necessary, but will help to make your environment both more efficient as well as more secure.  First, you will want to create an IAM policy called "securestack-ec2-allow-S3".  Copy this into your policy:
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::securestack",
                "arn:aws:s3:::securestack-elasticsearch-snapshots"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:ListObject"
            ],
            "Resource": [
                "arn:aws:s3:::securestack/",
                "arn:aws:s3:::securestack/*",
                "arn:aws:s3:::securestack-elasticsearch-snapshots/",
                "arn:aws:s3:::securestack-elasticsearch-snapshots/*"
            ]
        }
    ]
}
```

Next, you will want to create a role called "securestack-server-role" and attach the "securestack-ec2-allow-S3" policy to it.  Finally, search and find the "AmazonEC2FullAccess" policy and attach that to the "securestack-server-role".  Finally, in the AWS ec2 console attach the "securestack-server-role" to your SecureStack SIPServer instance.  This will allow you to create and manage SecureStack ec2 instances as well as backup parts of the SecureStack platform to S3.

#### AWS AMIs ####

**Region Name** | **Region** |  **AMI**
--- | --- | ---
US East (N. Virginia) | us-east-1 | ami-3a13ba40
US East (Ohio) | us-east-2 | ami-a03f10c5
US West (N. California) | us-west-1 | ami-d4625db4
US West (Oregon) | us-west-2 | ami-00ab6078
Asia Pacific (Mumbai) | ap-south-1 | ami-ebade084
Asia Pacific (Seoul) | ap-northeast-2 | ami-05a5016b
Asia Pacific (Singapore) | ap-southeast-1 | ami-be420fdd
Asia Pacific (Sydney) | ap-southeast-2 | ami-57e10f35
Asia Pacific (Tokyo) | ap-northeast-1 | ami-45ac0023
Canada (Central) | ca-central-1 | ami-4f55ed2b
EU (Frankfurt) | eu-central-1 | ami-ff55d090
EU (Ireland) | eu-west-1 | ami-9f8928e6
EU (London) | eu-west-2 | ami-6c6f7308
South America (São Paulo) | sa-east-1 | ami-f7cbb39b
US GovCloud | us-gov-west-1 | ami-7e14991f

#### Configuration ####

SSH is initially allowed to any source IPs which you'll want to change to allow access from only your known source IPs. These known source IPs are called your 'white_list'.  
Additionally, you'll want to limit access to the features of the SecureStack server to your AWS subnet.  Your local subnet is called your 'local_net'.

Once you know these values you can run the SecureStack configuration:
 
```/opt/securestack/scripts/securestack configure```

The configuration wizard will ask you to define your local_net and white_list as well as asking you if you want to enable or disable certain services.
The services you can enable/disable are:
* fail2ban
* ClamAV
* Linux Malware Detect
* Filebeat
* Metricbeat
* SCAP auditing tool
* Lynis system auditing
* Web Application Firewall

All configuration is contained in the /opt/securestack/securestack.yml file.  You can edit this file rather than running the configuration script.

#### Starting SecureStack ####

Once you've run the configuration wizard you can start the SecureStack engine: ```/opt/securestack/scripts/securestack start```

SecureStack Base is all ready to go now!  You can build whatever you want to using your SecureStack Base instances.

#### SecureStack SIPServer Web UI ####
SecureStack Server comes with a full featured web based SIEM and you should now be able to use the web ui.  At the end of the configuration process the securestack script will show you the url to use to connect to the SIPServer web ui.  process you would have had the opportunity to create a user and password for the the web ui.  When you are prompted for the username and password enter it.  In a browser you can open http://server_address_here to see the SecureStack Server UI.  If you can't connect, verify that your AWS security groups allow access to http (tcp 80). You can watch this [video to learn more about our SIEM] (https://youtu.be/oaBxbiCv1UU "Introduction to SecureStack SIEM")

During the configuration you would have had the opportunity to create a user and password for the the web ui. 

Enjoy!

Feel free to email us with any questions to support@securestack.com.au
