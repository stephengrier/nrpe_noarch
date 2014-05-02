
class nrpe_noarch::install {

  case $operatingsystem {

    default: {
      package { $::nrpe_noarch::nrpe_package:
        ensure  => installed,
      }
      package { $::nrpe_noarch::plugin_package_list:
        ensure => installed,
      }
    }
    AIX: {
      package { $::nrpe_noarch::nrpe_package:
        provider    => $::nrpe_noarch::package_provider,
        ensure      => installed,
        source      => $::nrpe_noarch::nrpe_package_source
      }
      # Install NRPE init script, not in the RPM for some reason.
      file {'/etc/rc.d/init.d/nrpe':
        ensure      => file,
        template    => template('nrpe_noarch/nrpe-startup-aix.erb'),
        owner       => 'root',
        group       => 'system',
        mode        => 0755
      }
      file {'/etc/rc.d/rc2.d/S80nrpe':
        ensure      => link,
        target      => '/etc/rc.d/init.d/nrpe',
        require     => [ Package['nrpe'], Package['nagios-plugins'],
                         File['/etc/rc.d/init.d/nrpe'] ]
      }
      package { $::nrpe_noarch::plugin_package_list:
        provider    => $::nrpe_noarch::package_provider,
        ensure      => installed,
        source      => $::nrpe_noarch::plugin_package_source
      }
    }
  }
}
    
