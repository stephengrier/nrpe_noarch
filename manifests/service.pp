class nrpe_noarch::service {

  service { $::nrpe_noarch::nrpe_service :
    ensure     => running,
    enable     => true,
    provider   => $::nrpe_noarch::service_provider,
    hasstatus  => $::operatingsystem ? { default  => true, Debian => false },
    hasrestart => true,
    start      => $::nrpe_noarch::startcmd,
    stop       => $::nrpe_noarch::stopcmd,
    restart    => $::nrpe_noarch::restartcmd,
    status     => $::nrpe_noarch::statuscmd,
    require    => Class['nrpe_noarch::install'],
  }
}
