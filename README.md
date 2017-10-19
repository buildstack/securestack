![alt text](https://cdn-images-1.medium.com/max/800/1*LEhyNwN6QMjflc_BtHvTMw.png "SecureStack")

# Welcome to SecureStack! #

### Initial Installation ###

After you've launched a SecureStack Standard instance from the AWS [Marketplace](https://ap-southeast-2.console.aws.amazon.com/ec2/v2/home?region=ap-southeast-2#LaunchInstanceWizard: "AWS Marketplace") you can ssh into the instance with the username securestack and the ssh key you provided.  SSH is initially allowed to any source IPs which you'll want to change to allow access from only your known source IPs. These known source IPs are called your 'white_list'.  
Additionally, you'll want to limit access to the features of the SecureStack server to your AWS subnet.  Your local subnet is called your 'local_net'.

Once you know these values you can run the SecureStack configuration: 
```/opt/securestack/scripts/securestack configure```

The configuration wizard will ask you to define your local_net and white_list as well as asking you if you want to enable or disable certain services.
The services you can enable/disable are:
*fail2ban
*clamav
*maldet 
*filebeat
*metricbeat

Once you've run the configuration wizard you can start the SecureStack engine: ```/opt/securestack/scripts/securestack start```

In a browser you can open http://server_address_here:5601 to see the SecureStack UI.  If you can't connect, verify that your AWS security groups allow access at tcp 5601.

Enjoy!

Feel free to email us with any questions to support@securestack.com.au
