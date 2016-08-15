# Class: bacula::config::director
#
# This module manages Bacula backup director
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::config::director
#
class bacula::config::director {

  # Setup Bacula director
  file {
    $bacula::params::config_confd_dir:
      ensure => directory,
      mode   => '0755',
      path   => $bacula::params::config_confd_dir;

    $bacula::params::config_confd_clients_dir:
      ensure => directory,
      mode   => '0755',
      path   => $bacula::params::config_confd_clients_dir;

    $bacula::params::config_confd_jobs_dir:
      ensure => directory,
      mode   => '0755',
      path   => $bacula::params::config_confd_jobs_dir;

    $bacula::params::config_director:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_director_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

      $bacula::params::config_bconsole:
        ensure  => file,
        mode    => '0644',
        content => template($bacula::params::config_bconsole_template),
        notify  => Service[$bacula::params::service_director],
        require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_catalog:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_catalog_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_client_director:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_client_director_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_console:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_console_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_director:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_director_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_fileset:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_fileset_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_job_backup_catalog:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_job_backup_catalog_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_job_director:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_job_director_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_job_restore:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_job_restore_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_jobdefs:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_jobdefs_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_messages:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_messages_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_pool:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_pool_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_schedule:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_schedule_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];

    $bacula::params::config_confd_storage:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_confd_storage_template),
      notify  => Service[$bacula::params::service_director],
      require => Package[$bacula::params::package_director_common];
  }

  # Create client configuration
  bacula::config::client { $bacula::backup_clients : }

  # Set Bacula to Use MySQL Library - By default, Bacula is set to use the PostgreSQL library.
  exec { 'Set Bacula to Use MySQL Library':
  path    => ['/usr/bin', '/usr/sbin', '/bin'],
  unless  => '/usr/sbin/dbcheck -B -c /etc/bacula/bacula-dir.conf | grep "db_type=MySQL"',
  command => 'echo 1 | /sbin/alternatives --config libbaccats.so',
  notify  => Service[$bacula::params::service_director],
  timeout => 1800,
  }
}
