# Setting up packer.io
class build::packer {
  $version = '0.12.1'

  ensure_resource('package', 'unzip', {'ensure' => 'present' })

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  $url = "https://releases.hashicorp.com/packer/${version}/packer_${version}_linux_amd64.zip"

  archive { "packer_${$version}_linux_amd64":
    ensure        => present,
    url           => $url,
    digest_string => '5f0a2a4e3fee8c3c85d2a2471ae41363',
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
