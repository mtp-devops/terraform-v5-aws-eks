#cloud-config
#

ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtdBTrAYXqvo6LfGucl5XOdibR2Y2FT9yYDPAWoiJq+S8xZG88k9uResie9x31Gm5V039+o9l4JqOIwU0oWY/6fz/DF7hgbat5RrZQ+cbVlqvha9UB730ptYcuxQTmoutzim6wOEfXBSB63N1QhaRsk5Y2kvUiIlhT3UvcdblTIpyBJmZNOuuzMWeIKhF5kwuMZzM7PAvCTZruRuLT2T79QOuQSZrH1MdHJtZi+IP1oSgu8EGSuxiUHELzMNBLSrJBvsKD/GZ0uKQGQ5r8TB7YSPTFa8+0xDxv7znKuc9pUwxbNdsEy9qzjn+Icub+8G/taiZS9mIktBuhs7AYQhQT cloud-init

packages:
 - kernel

package_update: true
package_upgrade: true
package_reboot_if_required: true
repo_update: true
repo_upgrade: all

runcmd:
  - sysctl -w vm.max_map_count=650000
  - /etc/eks/bootstrap.sh --docker-config-json '{"bridge":"none","log-driver":"json-file","log-opts":{"max-size":"100m","max-file":"10"},"live-restore":true,"max-concurrent-downloads":10}' --b64-cluster-ca '${cluster_auth_base64}' --apiserver-endpoint '${endpoint}' ${bootstrap_extra_args} --kubelet-extra-args "${kubelet_extra_args}" '${cluster_name}'
