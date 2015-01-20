# == Class: fluentd
#
# Full description of class fluentd here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class fluentd (
  $config_version            = $::fluentd::params::config_version,
  $config_dir                = $::fluentd::params::config_dir,
  $config_dir_d              = $::fluentd::params::config_dir_d,
  $config_dir_d_purge        = $::fluentd::params::config_dir_d_purge,
  $config_dir_d_purge_ignore = $::fluentd::params::config_dir_d_purge_ignore,
  $config_name               = $::fluentd::params::config_name,
  $package_name              = $::fluentd::params::package_name,
  $service_name              = $::fluentd::params::service_name,
  $daemon_user               = $::fluentd::params::daemon_user,
  $daemon_group              = $::fluentd::params::daemon_group,
) inherits ::fluentd::params {

  # validate parameters here

  class { '::fluentd::package': } ->
  class { '::fluentd::config': } ~>
  class { '::fluentd::service': } ->
  Class['::fluentd']
}
