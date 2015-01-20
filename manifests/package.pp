# == Class fluentd::package
#
# This class is called from fluentd for install.
#
class fluentd::package {

  package { $::fluentd::package_name:
    ensure => present,
  }
}
