class caddy inherits caddy::params {
  # Install
  include caddy::install
  include caddy::service

  # vhosts are defined in Hiera
}
