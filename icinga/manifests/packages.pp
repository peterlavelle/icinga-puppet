class icinga::packages{
	package{'nagios-plugins': ensure => installed}
	package{'nagios-plugins-standard': ensure => installed}
	package{'nagios-plugins-extra': ensure => installed} 

}