![alt text](https://cdn-images-1.medium.com/max/800/1*LEhyNwN6QMjflc_BtHvTMw.png "SecureStack")

# Welcome to SecureStack! #
SecureStack is a drop in security layer for all your IT infrastructure.  Think of us as a "Platform-Security-as-a-Service".  SecureStack comes in two forms:  SecureStack Base and SecureStack Server.  You can find both products here in the AWS [Marketplace](https://aws.amazon.com/marketplace/seller-profile?id=040c3d94-af50-430e-85a0-03719a4f9fad "AWS Marketplace")

### AWS Provisioning with SecureStack ###

* Make sure there is a server security group and know name:
	1. Allow ssh from $white_list network
		a. Allow http from $white_list network
		b. Allow tcp1514-1515 from $local_net
	2. Create base security group and know name:
		a. Allow ssh from $ossec_server_ip
	3. Run `/opt/securestack/scripts/securestack mfa`
	4. Run `kr pair` and pair your phone
	5. Edit /opt/securestack/ansible/launch_vars.yml for:
		a. Aws_access_key
		b. Aws_secret_key
		c. Vpc_subnet_id
		d. Authd passwordjj
		e. Group_id points at 3a from above
Run `/opt/securestack/scripts/securestack provision`

