# Setting up packer.io
class build::packer {
  $version = '0.8.6'

  ensure_resource('package', 'unzip', {'ensure' => 'present' })

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  $url = "https://dl.bintray.com/mitchellh/packer/packer_${$version}_linux_amd64.zip"

  archive { "packer_${$version}_linux_amd64":
    ensure        => present,
    url           => $url,
    digest_string => '4cda1c44cf666fada495dd8e01522e1c',
    src_target    => '/opt',
    target        => '/usr/share/packer/',
    extension     => 'zip',
    require       => Package['unzip'],
  } ->

  file{'/usr/bin/packer':
    ensure => link,
    target => "/usr/share/packer/packer_${version}_linux_amd64/packer"
  }
}
