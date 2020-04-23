define caddy::vhost (
  $external_port = 9100,
  $internal_port = 9101,
) {
  include ::caddy

  file { "/etc/caddy/config/${title}.conf":
    ensure => file,
    content => template('caddy/reverse_proxy.erb'),
    mode => '0444',
    require => Class['caddy'],
  } -> Service['caddy'],

}
