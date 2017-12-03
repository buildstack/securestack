![alt text](https://cdn-images-1.medium.com/max/800/1*LEhyNwN6QMjflc_BtHvTMw.png "SecureStack")

# Welcome to SecureStack! #
SecureStack is a drop in security layer for all your IT infrastructure.  Think of us as a "Platform-Security-as-a-Service".  SecureStack comes in two forms:  SecureStack Base and SecureStack Server.  You can find both products here in the AWS [Marketplace](https://aws.amazon.com/marketplace/seller-profile?id=040c3d94-af50-430e-85a0-03719a4f9fad "AWS Marketplace")

### SecureStack Base ###
SecureStack Base is intended to be the foundation you build all your AWS infrastrucuture with.  It is a hardened version of CentOS 7 and comes with many security applications baked right in.  So, if in the past you've used a Linux image from the AWS Marketplace, or a custom image you've built yourself you can replace it with our [SecureStack Base AMI](https://aws.amazon.com/marketplace/pp/B076JG5BHM/?ref=_ptnr_web_gh_readme_us "SecureStack Base AMI").  

SecureStack helps you meet your audit and compliance needs with multiple tools integrated into both Server and Base versions.  All SecureStack Base instances will report their compliance and audit data directly to their SecureStack Server controller.  SecureStack currently has modules for: PCI-DSS, OWASP, SCAP, and CIS.   

### SecureStack Server ###
SecureStack Server is your central management system that ties all your Base machines together.  SecureStack Server is a log collection, aggregation and analysis solution.  It's also a complete SIEM solution with real-time dashboards, custom visualizations and dashboards, event correlation, history and backup.  SecureStack Base instances talk to a SecureStack Server instance via an encrypted connection.  Events are passed in real-time so if an instance is compromised a hacker can't edit their history and make it disappear.  SecureStack Server already has the message and has alerted you to their presence.  SecureStack Server supports active response too.  If it sees an attack it can mitigate it with an automated response.  SecureStack Server also supports scheduled compliance checks.  Currently there are modules for: PCI-DSS, OWASP, SCAP, and CIS.   

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

After you've launched a SecureStack Base or Server instance you can ssh into it with the username securestack and the ssh key you provided. The first thing you will want to do is update the SecureStack sofware and operating system.

To update all versions of SecureStack run this from the command line:

```/opt/securestack/scripts/securestack update```

This command updates the CentOS operating system so occasionally you will have to run the update twice and reboot if there are any significant updates that require it.  The updater will let you know if you need to reboot.  When your system is done upgrading it will let you know by returning a 'Your operating system is up to date' message.  If you see this message you are safe to run the configuration next.

#### AWS: S3, and IAM ####

If you are going to run SecureStack workloads in AWS there are a couple things you can do to optimize your configuration.  These steps are not strictly necessary, but will help to make your environment both more efficient as well as more secure.  First, you will want to create an IAM role called "securestack-ec2-allow-S3".  Copy this into your policy:
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
         "ec2:RunInstances",
         "ec2:AssociateIamInstanceProfile",
         "ec2:ReplaceIamInstanceProfileAssociation"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "iam:PassRole",
      "Resource": "*"
    }
  ]
}
```

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

All configuration is contained in the /opt/securestack/securestack.yml file.  You can edit this file rather than running the configuration script.

#### Starting SecureStack ####

Once you've run the configuration wizard you can start the SecureStack engine: ```/opt/securestack/scripts/securestack start```

SecureStack Base is all ready to go now!  You can build whatever you want to using your SecureStack Base instances.

#### SecureStack Server Web UI ####
SecureStack Server comes with a full featured web based SIEM and you should now be able to use the web ui.  In a browser you can open http://server_address_here to see the SecureStack Server UI.  If you can't connect, verify that your AWS security groups allow access to http (tcp 80).

The username for the web ui is securestack and the password should have been displayed during the configuration process.  You can also find the password in the securestack.yml configuration file.

Enjoy!

Feel free to email us with any questions to support@securestack.com.au
