# Class: nrpe_noarch
#
# This class installs and managed nrpe. It managed the main nrpe.cfg file
# and creates files for each nrpe check command in /etc/nrpe.d. It can
# additionally add sudo config snippets in /etc/sudoers.d for check commands
# that require root privileges.
#
# The nrpe_noarch module will configure nrpe on RedHat, Debian and AIX hosts.
#
# Author: Stephen Grier
#
# Parameters:
#
# Actions:
#  - Install nrpe
#  - Manage nrpe check command configuration
#  - Manage required sudo config
#  - Add iptables rule as required.
#
# Requires:
#  - The nrpe_noarch::firewall class uses the iptables module.
#
# Sample Usage:
#
#    class { 'nrpe_noarch': allowed_hosts => '127.0.0.1,192.168.0.10', firewall => true }
#    nrpe_noarch::command { 'check_zombie_procs':
#      check_command => 'check_procs',
#      command_args => '-w 5 -c 10 -s Z',
#      sudo => true
#    }
#
class nrpe_noarch (
  $allowed_hosts, # comma separated list of ips that can talk to nrpe
  $port = $::nrpe_noarch::params::port,
  $user = $::nrpe_noarch::params::user,
  $group = $::nrpe_noarch::params::group,
  $port = $::nrpe_noarch::params::port,
  $command_timeout = $::nrpe_noarch::params::command_timeout,
  $connection_timeout = $::nrpe_noarch::params::connection_timeout,
  $nagios_plugin_dir = $::nrpe_noarch::params::nagios_plugin_dir,
  $nrpe_package = $::nrpe_noarch::params::nrpe_package,
  $nrpe_package_source = $::nrpe_noarch::params::nrpe_package_source,
  $package_provider = $::nrpe_noarch::params::package_provider,
  $nrpe_cfg = $::nrpe_noarch::params::nrpe_cfg,
  $include_dir = $::nrpe_noarch::params::include_dir,
  $pid_file = $::nrpe_noarch::params::pid_file,
  $nrpe_service = $::nrpe_noarch::params::nrpe_service,
  $service_provider = $::nrpe_noarch::params::service_provider,
  $startcmd = $::nrpe_noarch::params::startcmd,
  $stopcmd = $::nrpe_noarch::params::stopcmd,
  $restartcmd = $::nrpe_noarch::params::restartcmd,
  $statuscmd = $::nrpe_noarch::params::statuscmd,
  $firewall = true,
) inherits ::nrpe_noarch::params {
  class{'nrpe_noarch::install':} ->
  class{'nrpe_noarch::config':} ~>
  class{'nrpe_noarch::service':} ->
  class{'nrpe_noarch::firewall':} ->
  Class['nrpe_noarch']

}
