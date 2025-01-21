class caddy::install {

  group { $caddy::caddy_group:
    ensure => present,
    gid    => $caddy::caddy_gid,
    system => true,
  }

  user { $caddy::caddy_user:
    ensure     => present,
    shell      => '/usr/sbin/nologin',
    gid        => $caddy::caddy_gid,
    uid        => $caddy::caddy_uid,
    system     => true,
    home       => $caddy::caddy_home,
    managehome => true,
  }

  file { $caddy::caddy_ssl_dir:
    ensure  => directory,
    owner   => $caddy::caddy_user,
    group   => $caddy::caddy_group,
    mode    => '0755',
    require => User[$caddy::caddy_user],
  }

  file { '/etc/caddy/':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  } ->
  file { '/etc/caddy/config':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  } ->
  file { '/etc/caddy/Caddyfile':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/caddy/Caddyfile",
  }


  include archive

  # Hard coded Latest and amd64
  archive { "/usr/local/bin/caddy":
    ensure       => present,
    # VERSION 1 IS NO LONGER AVAILABLE. HACK UNTIL WE CAN UPDATE THIS TO SUPPORT V2
    source       => "https://swift-yyc.cloud.cybera.ca:8080/v1/AUTH_26e8c07d5d384c0a8656b0b6d5feea69/public/caddy",
    extract      => false,
    extract_path => "/usr/local/bin",
    creates      => "/usr/local/bin/caddy",
    cleanup      => false,
  }

  file { "/usr/local/bin/caddy":
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Archive["/usr/local/bin/caddy"],
  }

}
