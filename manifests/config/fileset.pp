# Class: bacula::config::fileset
#
# This module manages Bacula backup filesets
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage:
#
define bacula::config::fileset (
  $client_fqdn      = $title,
  $name             = 'filesetname',
  $includes         = ['/etc', '/var'],
  $excludes         = ['/tmp', '/home/venkatp'],
  ) {

  # Define local variables for template
  $local_client_fqdn     = $client_fqdn
  $local_name            = $name
  $local_includes        = $includes
  $local_excludes        = $excludes

  # Create fileset defintion
  file { "${bacula::params::config_confd_filesets_dir}/${client_fqdn}.conf":
    ensure  => file,
    mode    => '0644',
    content => template($bacula::params::config_confd_fileset_template),
    notify  => Service[$bacula::params::service_director],
    require => Package[$bacula::params::package_director_mysql];
  }

}
