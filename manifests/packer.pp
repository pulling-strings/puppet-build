# Setting up packer.io
class build::packer {
  $version = '0.5.1'

  ensure_resource('package', 'unzip', {'ensure' => 'present' })

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  $url = "https://dl.bintray.com/mitchellh/packer/${$version}_linux_amd64.zip"

  archive { $version:
    ensure        => present,
    url           => $url,
    digest_string => 'a7113453e8b46f64673c8e87d595166c',
    src_target    => '/opt',
    target        => "/usr/share/packer-${version}",
    extension     => 'zip',
    require       => Package['unzip'],
  } ->

  file { '/usr/share/packer':
    ensure  => link,
    target  => "/usr/share/packer-${version}",
    owner   => root,
    group   => root
  } ->

  file{'/usr/bin/packer':
    ensure => link,
    target => '/usr/share/packer/packer'
  }
}
