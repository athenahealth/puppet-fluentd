# == Class: fluentd
#
# Manage Fluentd installation and configuration with Puppet.
#
# === Parameters
#
# [*config_version*] (default: 1)
#   Version of configuration file to use.
#   See http://docs.fluentd.org/articles/config-file#v1-format for details.
#
# [*config_dir*] (default: /etc/td-agent)
#   Path to the main configuration directory.
#
# [*config_dir_d*] (default: /etc/td-agent/config.d)
#   Path to the configuration directory for dynamic configlets.
#
# [*config_dir_d_purge*] (default: true)
#   Purge configuration directory for dynamic configlets of unmanaged configs.
#
# [*config_dir_d_purge_ignore*] (default: undef)
#   Exclude certain files from being purged.
#
# [*config_name*] (default: /etc/td-agent/td-agent.conf)
#   Path to the main configuration file.
#
# [*package_name*] (default: td-agent)
#   Override the package name.
#
# [*service_name*] (default: td-agent)
#   Override the service name.
#
# [*daemon_user*] (default: td-agent)
#   Override the daemon user.
#
# [*daemon_group*]
#   Override the daemon group.
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
