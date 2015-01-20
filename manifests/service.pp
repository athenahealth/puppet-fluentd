# == Class fluentd::service
#
# This class is meant to be called from fluentd.
# It ensure the service is running.
#
class fluentd::service {

  service { $::fluentd::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
