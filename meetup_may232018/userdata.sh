#!/bin/bash -v
yum install wget unzip -y
wget https://releases.hashicorp.com/vault-ssh-helper/0.1.4/vault-ssh-helper_0.1.4_linux_amd64.zip
unzip vault-ssh-helper_0.1.4_linux_amd64.zip
cp vault-ssh-helper /usr/local/bin/
chmod +x /usr/local/bin/vault-ssh-helper
mkdir /etc/vault-ssh-helper.d
cat <<EOF > /etc/vault-ssh-helper.d/config.hcl
vault_addr = "http://vault-vault.apps.ocp.lab.arctiq.ca:80"
ssh_mount_point = "ssh"
tls_skip_verify = true
allowed_roles = "*"
allowed_cidr_list = "0.0.0.0/0"
EOF
cat <<EOF > /etc/pam.d/sshd
#%PAM-1.0
auth	     required	pam_sepermit.so
#auth       include      password-auth
auth       requisite    pam_exec.so quiet expose_authtok log=/var/log/vaultssh.log /usr/local/bin/vault-ssh-helper -dev -config=/etc/vault-ssh-helper.d/config.hcl
auth       optional     pam_unix.so not_set_pass use_first_pass nodelay
account    required     pam_nologin.so
account    include      password-auth
password   include      password-auth
# pam_selinux.so close should be the first session rule
session    required     pam_selinux.so close
session    required     pam_loginuid.so
# pam_selinux.so open should only be followed by sessions to be executed in the user context
session    required     pam_selinux.so open env_params
session    required     pam_namespace.so
session    optional     pam_keyinit.so force revoke
session    include      password-auth
EOF
sed "s/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g;s/PasswordAuthentication yes/PasswordAuthentication no/g;s/UsePAM no/UsePAM yes/g" /etc/ssh/sshd_config > /etc/ssh/sshd_config
service sshd restart
touch /tmp/finished-user-data
