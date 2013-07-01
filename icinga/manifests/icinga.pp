#Run on puppetmaster to generate configs
class icinga::icinga {

include icinga::packages
  
$baseconfigdir="/etc/icinga/modules"
$conf_file_hosts="hosts_pupp_gen.cfg"
$conf_file_srvs="srvs_pupp_gen.cfg"


Nagios_host <<||>> {

  target => "${baseconfigdir}/${conf_file_hosts}",
  notify => Service['icinga']
}

file { "${baseconfigdir}/${conf_file_hosts}":
  ensure   => "file",
  owner    => "nagios",
  group    => "nagios",
  mode     => "0644",
  notify   => Service['icinga']
}

Nagios_service <<||>> {

  target => "${baseconfigdir}/${conf_file_srvs}",
  notify => Service['icinga']
 }

file { "${baseconfigdir}/${conf_file_srvs}":
  ensure => "file",
  owner  => "nagios",
  group  => "nagios",
  mode   => "0644",
  notify => Service['icinga']
}

service{'icinga':
  ensure     => running,
  hasrestart => true,
  hasstatus  => true,
  restart    => 'service icinga restart'
}


}
