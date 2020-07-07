class caddy (
  Hash $reverse_proxies = {},
) inherits caddy::params {
  # Install
  include caddy::install
  include caddy::service

  # vhosts are defined in Hiera
  if $reverse_proxies {
    notify { 'test': }
    create_resources(caddy::vhost, $reverse_proxies)
  }

}
