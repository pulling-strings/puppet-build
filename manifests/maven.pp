# installing maven
class build::maven($version='2.2.1', $md5='83fc9b8e7fbcd89fccfdee0e50c54bab') {

  ensure_resource('package', 'unzip', {ensure  => present })

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  $url = "https://archive.apache.org/dist/maven/binaries/apache-maven-${version}-bin.zip"

  archive { $version:
    ensure        => present,
    url           => $url,
    digest_string => $md5,
    src_target    => '/usr/share',
    target        => '/usr/share',
    extension     => 'zip',
    require       => Package['unzip'],
  } ->

  file { '/usr/share/maven':
    ensure  => link,
    target  => "/usr/share/apache-maven-${version}",
    owner   => root,
  } ->

  file{'/usr/bin/mvn':
    ensure => link,
    target => '/usr/share/maven/bin/mvn'
  }


}
