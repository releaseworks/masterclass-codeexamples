# Lesson: Openstack

In this lesson, we'll be using Openstack with DevStack. DevStack is a tool that runs a complete Openstack environment on a single server. Because installing DevStack requires various changes to network configuration of the server it's installed on, we'll be creating a new virtual machine for it in Google Cloud Platform.

Using the skills you have learned in the previous lessons, provision a new virtual machine on Google Compute Engine. Create a server with 2 VCPUs, 8 gigabytes of memory and 100GB root disk with the Ubuntu 16.04 operating system. Also, create a firewall rule to allow TCP port 80 inbound from any source.

Finally, SSH into the new virtual machine (either via Google Cloud Shell or externally) and follow the instructions below to install DevStack. Note that the installation will take about 15 minutes.

## Install DevStack

First, create a user for running DevStack:
```
sudo useradd -s /bin/bash -d /opt/stack -m stack
```

Enable this user to sudo without a password:
```
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
```

Open a shell as the stack user:
```
sudo su - stack
```

Download DevStack via git:
```
git clone https://git.openstack.org/openstack-dev/devstack
cd devstack
```

Create the minimum configuration for installing DevStack:
```
echo -e "[[local|localrc]]\nADMIN_PASSWORD=masterclass\nDATABASE_PASSWORD=\$ADMIN_PASSWORD\nRABBIT_PASSWORD=\$ADMIN_PASSWORD\nSERVICE_PASSWORD=\$ADMIN_PASSWORD" > local.conf
```

Start the DevStack installation:
```
./stack.sh
```

When the installation is complete, login to the Openstack dashboard in `http://<VIRTUAL_MACHINE_PUBLIC_IP>/dashboard/` using the username `demo` and password `masterclass`.

