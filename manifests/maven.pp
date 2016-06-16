# installing maven
class build::maven($version='3.0.5', $md5='20b830ab3aa3fec221e85f9dd1fcbedd') {

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
    ensure => link,
    target => "/usr/share/${version}/apache-maven-${version}",
    owner  => root,
  } ->

  file{'/usr/bin/mvn':
    ensure => link,
    target => '/usr/share/maven/bin/mvn'
  }


}
