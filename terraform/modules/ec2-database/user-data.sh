
# Exit immediately if any command fails (safer scripting)
set -e

dnf update -y

dnf install -y amazon-ssm-agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

dnf install -y \
    postgresql${postgres_version} \
    postgresql${postgres_version}-server \
    postgresql${postgres_version}-contrib

sleep 10

# Create a filesystem on the EBS volume
mkfs.xfs ${db_volume_device}

mkdir -p /var/lib/pgsql

mount ${db_volume_device} /var/lib/pgsql




UUID=$(blkid -s UUID -o value ${db_volume_device})
# Add entry to /etc/fstab so volume mounts automatically after reboot
echo "UUID=$UUID /var/lib/pgsql xfs defaults,nofail 0 2" >> /etc/fstab

chown -R postgres:postgres /var/lib/pgsql

chmod 700 /var/lib/pgsql

