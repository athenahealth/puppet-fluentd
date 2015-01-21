# == definition fluentd::forest_match
define fluentd::forest_match (
  $pattern,
  $ensure   = present,
  $config   = {},
  $priority = 50,
) {
  fluentd::configfile { "match-${name}":
    ensure   => $ensure,
    content  => template( 'fluentd/forest_match.erb' ),
    priority => $priority,
  }
}