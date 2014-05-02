
class nrpe_noarch::config {

  $pid_file = $::nrpe_noarch::pid_file
  $port = $::nrpe_noarch::port
  $user = $::nrpe_noarch::user
  $group = $::nrpe_noarch::group
  $nagios_plugin_dir = $::nrpe_noarch::nagios_plugin_dir
  $allowed_hosts = $::nrpe_noarch::allowed_hosts
  $command_timeout = $::nrpe_noarch::command_timeout

  file { $::nrpe_noarch::nrpe_cfg :
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('nrpe_noarch/nrpe.cfg.erb'),
    notify  => Class['nrpe_noarch::service'],
  }

  file { '/etc/nrpe.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

}

