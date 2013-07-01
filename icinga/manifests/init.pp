#init.pp for icinga module
class icinga{
	include icinga::icinga, icinga::observed, icinga::packages
}
