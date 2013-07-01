#Run on non-master node to add checks
class icinga::observed {

 include icinga::packages


  $prefix="PG"


   @@nagios_host { "$fqdn":
       ensure => present,
       alias => $hostname,
       address => $ipaddress,
       use => "linux-server",
       require => Class['icinga::packages']
  }

  @@nagios_service { "check_ping_${hostname}":
       check_command => "check_ping!100.0,20%!500.0,60%",
       use => "generic-service",
       host_name => "$fqdn",
       service_description => "$prefix PING: ${hostname}",
       require => Class['icinga::packages']
  }

  @@nagios_service { "check_ssh_${hostname}":
       check_command => "check_ssh!$fqdn",
       use => "generic-service",
       host_name => "$fqdn",
       service_description => "$prefix SSHD: ${hostname}",
       require => Class['icinga::packages']
  }
   @@nagios_service { "check_ssh_load_${hostname}":
       check_command => "check_ssh_load!22!5.0,4.0,3.0!8.0,7.0,6.0",
       use => "generic-service",
       host_name => "$fqdn",
       service_description => "$prefix LOAD: ${hostname}",
       require => Class['icinga::packages']
  }

   @@nagios_service { "check_ssh_disk_${hostname}":
       check_command => "check_ssh_disk!22!10!8!/",
       use => "generic-service",
       service_description => "$prefix ROOT PARTITION SPACE: ${hostname}",
       host_name => "$fqdn",
       require => Class['icinga::packages']
  }


  @@nagios_service { "check_ssh_disk_tmp_${hostname}":
       check_command => "check_ssh_disk!22!10!8!/tmp",
       use => "generic-service",
       service_description => "$prefix /tmp PARTITION SPACE: ${hostname}",
       host_name => "$fqdn",
       require => Class['icinga::packages']
  }

  @@nagios_service { "check_ssh_swap_${hostname}":
       check_command => "check_ssh_swap!22!30%!20%",
       use => "generic-service",
       service_description => "$prefix SWAP USAGE: ${hostname}",
       host_name => "$fqdn",
       require => Class['icinga::packages']
  }

   @@nagios_service { "check_ssh_apt_${hostname}":
       check_command => "check_ssh_apt",
       use => "generic-service",
       service_description => "$prefix APT Package Updates: ${hostname}",
       host_name => "$fqdn",
       require => Class['icinga::packages']
  }


}
