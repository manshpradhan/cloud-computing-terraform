# Install and Configure OpenVPN on Amazon Linux 2

This guide will walk you through the process of installing and configuring OpenVPN on Amazon Linux 2. It includes steps to provision an EC2 instance using Terraform and then set up OpenVPN Access Server.

## Prerequisites

- Terraform installed on your system.
- AWS CLI configured with proper credentials and region.
- Access to a GitHub repository with Terraform scripts for EC2 deployment.

---

## Steps to Set Up OpenVPN

### Step 1: Clone the Terraform Repository

1. **Clone the Repository**

   ```bash
   git clone https://github.com/manshpradhan/Cloud-Computing.git
   ```

2. **Navigate to the Terraform Directory**

   ```bash
   cd Cloud-Computing
   ```

---

### Step 2: Initialize Terraform

Run the following command to initialize Terraform:

```bash
terraform init
```

This command downloads the required provider plugins and sets up your working directory.

---

### Step 3: Review the Terraform Plan

Review the configuration to ensure it meets your requirements:

```bash
terraform plan
```

This command previews the resources that Terraform will create.

---

### Step 4: Apply the Terraform Configuration

Deploy the EC2 instance by applying the Terraform configuration:

```bash
terraform apply
```

Type `yes` when prompted to confirm.

---

### Step 5: Note the Output

Once the instance is created, Terraform will display the **public** and **private** IP addresses of the instance. Note the public IP address, as you will need it to access the OpenVPN Admin Web UI.

---

### Step 6: Install OpenVPN on the EC2 Instance

1. **Update the System**

   ```bash
   sudo yum update -y
   ```

2. **Install the OpenVPN Repository**

   ```bash
   sudo yum -y install https://as-repository.openvpn.net/as-repo-amzn2.rpm
   ```

3. **Install OpenVPN Access Server**

   ```bash
   sudo yum -y install openvpn-as
   ```

---

### Step 7: Access the OpenVPN Admin Web UI

1. **Identify the Admin Web URL**

   After installation, the terminal will display a URL similar to:

   ```
   https://<PRIVATE_IP>:943/admin
   ```

2. **Replace Private IP with Public IP**

   Replace `<PRIVATE_IP>` with the public IP address of your EC2 instance for external access. You can find the public IP using:

   ```bash
   echo $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
   ```

3. **Log In to the Admin Web UI**

   Open the URL in your web browser:

   ```
   https://<PUBLIC_IP>:943/admin
   ```

   Use the default credentials:

   - **Username:** openvpn
   - **Password:** Automatically generated (displayed during installation).

4. **Change the Default Password**

   For security, update the default password when prompted.

---

### Post-Installation Configuration

Once logged in, you can:

- Configure VPN settings.
- Add or manage users.
- Enable additional security settings.

---

## Additional Notes

- Ensure your security group allows access to the required ports (e.g., 943, 443).
- Assign an Elastic IP to your instance to avoid URL changes after reboots.
- To reset the admin password, run:

  ```bash
  sudo passwd openvpn
  ```

- For detailed information, refer to the [OpenVPN Access Server Documentation](https://openvpn.net/access-server/).

---

## Conclusion

You now have a secure and fully functional OpenVPN setup on Amazon Linux 2. Enjoy your private and safe VPN!

---

**Happy VPNing!** 🌐
