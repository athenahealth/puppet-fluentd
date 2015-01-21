# == definition fluentd::match
define fluentd::match (
  $pattern,
  $ensure   = present,
  $config   = {},
  $priority = 50,
) {
  fluentd::configfile { "match-${name}":
    ensure   => $ensure,
    content  => template( 'fluentd/match.erb' ),
    priority => $priority,
  }
}