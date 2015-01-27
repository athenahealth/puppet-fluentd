# == Class fluentd::params
#
# This class is meant to be called from fluentd.
# It sets variables according to platform.
#
class fluentd::params {
  # config
  $config_version            = '1'
  $config_dir                = '/etc/td-agent'
  $config_dir_d              = "${config_dir}/config.d"
  $config_name               = "${config_dir}/td-agent.conf"
  $config_dir_d_purge        = true
  $config_dir_d_purge_ignore = undef
  
  case $::osfamily {
    'Debian': {
      $package_name = 'td-agent'
      $service_name = 'td-agent'
      $daemon_user  = 'td-agent'
      $daemon_group = 'td-agent'
    }
    'RedHat', 'Amazon': {
      $package_name = 'td-agent'
      $service_name = 'td-agent'
      $daemon_user  = 'td-agent'
      $daemon_group = 'td-agent'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
