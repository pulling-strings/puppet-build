# Setting up packer.io
class build::packer {
  $version = '0.7.5'

  ensure_resource('package', 'unzip', {'ensure' => 'present' })

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  $url = "https://dl.bintray.com/mitchellh/packer/${$version}_linux_amd64.zip"

  archive { $version:
    ensure        => present,
    url           => $url,
    digest_string => 'f343d709b84db494e8d6ec38259aa4a6',
    src_target    => '/opt',
    target        => '/usr/share/packer/',
    extension     => 'zip',
    require       => Package['unzip'],
  } ->

  file{'/usr/bin/packer':
    ensure => link,
    target => "/usr/share/packer/${version}/packer"
  }
}
