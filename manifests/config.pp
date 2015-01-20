# == Class fluentd::config
#
# This class is called from fluentd for service config.
#
class fluentd::config {
  
  file { 'fluentd_config_dir':
    ensure => 'directory',
    path   => $fluentd::config_dir,
    owner  => $fluentd::daemon_user,
    group  => $fluentd::daemon_group,
    mode   => '0755',
    } ->
  
  file { 'fluentd_config_name':
    ensure  => 'file',
    path    => $fluentd::config_name,
    owner   => $fluentd::daemon_user,
    group   => $fluentd::daemon_group,
    mode    => '0640',
    content => template('fluentd/fluentd.conf.erb'),
    notify  => Class['fluentd::service'],
    } ->

  file { 'fluentd_config_dir_d':
    ensure  => 'directory',
    path    => $fluentd::config_dir_d,
    owner   => $fluentd::daemon_user,
    group   => $fluentd::daemon_group,
    mode    => '0755',
    recurse => $fluentd::config_dir_d_purge,
    purge   => $fluentd::config_dir_d_purge,
    ignore  => $fluentd::config_dir_d_purge_ignore,
  }

}
