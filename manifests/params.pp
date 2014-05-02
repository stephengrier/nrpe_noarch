class nrpe_noarch::params {
  $port = 5666
  $command_timeout = 180
  $connection_timeout = 300

  case $::operatingsystem {
    RedHat,CentOS: {
      $user = 'nrpe'
      $group = 'nrpe'
      $nrpe_package = 'nrpe'
      $nrpe_cfg = '/etc/nagios/nrpe.cfg'
      $include_dir = '/etc/nrpe.d'
      $pid_file = '/var/run/nrpe/nrpe.pid'
      $nagios_plugin_dir = $::architecture ? {
        'x86_64' => '/usr/lib64/nagios/plugins',
        default => '/usr/lib/nagios/plugins'
      }
      $nrpe_service = 'nrpe'
      $service_provider = undef
      $startcmd = undef
      $stopcmd = undef
      $restartcmd = undef
      $statuscmd = undef
    }
    /(Debian|Ubuntu)/: {
      $user = 'nrpe'
      $group = 'nrpe'
      $nrpe_package = 'nagios-nrpe-server'
      $nrpe_cfg = '/etc/nagios/nrpe.cfg'
      $include_dir = '/etc/nrpe.d'
      $pid_file = '/var/run/nagios/nrpe.pid'
      $nagios_plugin_dir = $::architecture ? {
        'x86_64' => '/usr/lib64/nagios/plugins',
        default => '/usr/lib/nagios/plugins'
      }
      $nrpe_service = 'nagios-nrpe-server'
      $service_provider = undef
      $startcmd = undef
      $stopcmd = undef
      $restartcmd = undef
      $statuscmd = undef
    }
    AIX: {
      $user = 'nobody'
      $group = 'nobody'
      $nrpe_package = 'nrpe-2.12-ucl'
      $nrpe_package_source = '/aix/nagios/nrpe-2.12-ucl.aix6.1.ppc.rpm'
      $package_provider = 'aixrpm'
      $nrpe_cfg = '/opt/freeware/etc/nrpe.cfg'
      $include_dir = '/opt/freeware/etc/nrpe.d'
      $pid_file = '/var/run/nrpe.pid'
      $nagios_plugin_dir = '/opt/freeware/libexec'
      $nrpe_service = 'nrpe'
      $service_provider = 'init'
      $startcmd = '/etc/rc.d/init.d/nrpe start'
      $stopcmd = '/etc/rc.d/init.d/nrpe stop'
      $restartcmd = '/etc/rc.d/init.d/nrpe restart'
      $statuscmd = '/etc/rc.d/init.d/nrpe status'
    }
    default: { fail("Operating system $operatingsystem is not supported by nrpe_noarch") }
  }
  case $::osfamily {
    RedHat: {
      $plugin_package_list = ['nagios-plugins-all',
                              'nagios-plugins-nrpe',
                              'nagios-plugins-radius',
                              'nagios-plugins-linux_raid']
    }
    Debian: {
      $plugin_package_list = ['libnagios-plugin-perl','nagios-plugins-extra','nagios-plugins-basic','nagios-plugins-standard', 'nagios-plugins']
    }
    AIX: {
      $plugin_package_list = ['nagios-plugins-1.4.15-ucl']
      $plugin_package_source = '/aix/nagios/nagios-plugins-1.4.15-ucl.aix6.1.ppc.rpm'
    }
  }
}
