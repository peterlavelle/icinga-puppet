#Run on non-master node to add checks
class icinga::observed {

 include icinga::packages

  #Prefix to prepend to each check name
  $prefix="PG"

  ##Basic checks added for each provisioned host


   #Ping check
   @@nagios_host { "$fqdn":
       ensure => present,
       alias => $hostname,
       address => $ipaddress,
       use => "linux-server",
       require => Class['icinga::packages']
  }

  #SSHd Check
  @@nagios_service { "check_ssh_${hostname}":
       check_command => "check_ssh!$fqdn",
       use => "generic-service",
       host_name => "$fqdn",
       service_description => "$prefix SSHD: ${hostname}",
       require => Class['icinga::packages']
  }
   

}
