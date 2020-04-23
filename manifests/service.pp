class caddy::service {

  # Only supports systemd
  # Use systemd...
  systemd::unit_file { 'caddy.service':
    content => template('caddy.service.erb'),
    notify => Service['caddy'],
  }

  service { 'caddy':
    ensure => running,
    name => 'caddy',
    enable => true,
    provider => systemd, 
  }

}
