# == definition fluentd::configfile
define fluentd::configfile(
  $content,
  $ensure       = present,
  $priority     = 50,
  $daemon_user  = $fluentd::daemon_user,
  $daemon_group = $fluentd::daemon_group,
) {
  $base_name     = "${name}.conf"
  $conf_name     = "${priority}-${base_name}"
  $conf_path     = "${fluentd::config_dir_d}${conf_name}"
  $wildcard_path = "${fluentd::config_dir_d}*-${base_name}"

  file { $conf_path:
    ensure  => $ensure,
    content => $content,
    owner   => $daemon_user,
    group   => $daemon_group,
    mode    => '0640',
    require => Class['fluentd::package'],
    notify  => Class['fluentd::service'],
  }
}