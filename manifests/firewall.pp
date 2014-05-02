class nrpe_noarch::firewall {

  $allowed_hosts = split($::nrpe_noarch::allowed_hosts, ',')

  if $::nrpe_noarch::firewall {
    case $::operatingsystem {
      RedHat,CentOS,Debian,Ubuntu: {
        iptables {'allow NRPE':
          chain   => 'INPUT',
          state => 'NEW',
          proto   => 'tcp',
          source => $allowed_hosts,
          dport   => '5666',
          jump    => 'ACCEPT'
        }
      }
      default: { fail("Cannot open firewall on $operatingsystem") }
    }
  }

}
