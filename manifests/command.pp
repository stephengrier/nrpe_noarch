
define nrpe_noarch::command (
  $check_command,
  $ensure = 'file',
  $command_args = '',
  $sudo = false
) {
  if ! defined(Class['nrpe_noarch']) {
    fail('You must include the nrpe_noarch class before using nrpe_noarch::command resources')
  }

  $user = $::nrpe_noarch::user
  $nagios_plugin_dir = $::nrpe_noarch::nagios_plugin_dir

  file { "${::nrpe_noarch::include_dir}/${name}.cfg":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('nrpe_noarch/nrpe_service.cfg.erb'),
    notify  => Class['nrpe_noarch::service'],
  }

  if $sudo == true {
    # Setup sudo rules for this command.
    file { "/etc/sudoers.d/${name}":
      ensure => $ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0440',
      content => template('nrpe_noarch/sudo.erb')
    }
  }
}
