chmod 750 /etc/sudoers.d
echo "Legal Banner : Attention, by continuing to connect to this system, you consent to the owner storing a log of all activity. Unauthorized access is prohibited." > /etc/issue 
echo "Legal Banner : Attention, by continuing to connect to this system, you consent to the owner storing a log of all activity. Unauthorized access is prohibited." > /etc/issue.net
echo "kernel.sysrq = 0" >> /etc/sysctl.conf
echo "dev.tty.ldisc_autoload = 0" >> /etc/sysctl.conf
echo "fs.protected_fifos = 2" >> /etc/sysctl.conf
echo "fs.protected_regular = 2" >> /etc/sysctl.conf
echo "kernel.modules_disabled = 1" >> /etc/sysctl.conf
echo "kernel.core_uses_pid = 1" >> /etc/sysctl.conf
echo "kernel.kptr_restrict = 2" >> /etc/sysctl.conf 
echo "net.ipv4.conf.all.forwarding = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.accept_redirects = 0">> /etc/sysctl.conf
echo "*                hard    core            0" >> /etc/security/limits.conf
echo "umask 027" >> /etc/bash.bashrc ; echo "umask 027" >> /etc/profile ; echo "umask 027" >> /etc/profile.d/99-umask.sh
echo "TMOUT=900" >> /etc/bash.bashrc  ; echo "TMOUT=900" >> /etc/profile ; echo "TMOUT=900" >> /etc/profile.d/99-tmout.sh
mkdir -p /etc/cron.daily ;  mkdir -p /etc/cron.weekly 
chmod 0700 /etc/cron.daily ;  chmod 0700 /etc/cron.weekly
echo "Defaults use_pty" >> /etc/sudoers
echo 'Defaults logfile="/var/log/sudo.log"' >> /etc/sudoers
chmod 0400 /etc/sudoers
echo "PASS_MAX_DAYS 365" >> /etc/login.defs ; echo "PASS_MIN_DAYS 1" >> /etc/login.defs
apt-get update
apt-get dist-upgrade -y
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends init tzdata ntp suricata aide aide-common
/usr/sbin/aideinit
sed -i.bak 's/RUN=no/RUN=yes/g' /etc/default/suricata
rm -rf /var/lib/apt/lists/*
service suricata start
service ntp start
sysctl -p
