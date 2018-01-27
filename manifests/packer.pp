# Setting up packer.io
class build::packer {
  $version = '1.1.3'

  ensure_resource('package', 'unzip', {'ensure' => 'present' })

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  $url = "https://releases.hashicorp.com/packer/${version}/packer_${version}_linux_amd64.zip"

  archive { "packer_${version}_linux_amd64":
    ensure        => present,
    url           => $url,
    digest_string => 'b7982986992190ae50ab2feb310cb003a2ec9c5dcba19aa8b1ebb0d120e8686f',
    digest_type   => 'sha256',
    src_target    => '/opt',
    target        => '/usr/share/packer/',
    extension     => 'zip',
    require       => Package['unzip'],
  }

  -> file{'/usr/bin/packer':
    ensure => link,
    target => "/usr/share/packer/packer_${version}_linux_amd64/packer"
  }
}
