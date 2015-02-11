# setting up sbt
class build::sbt {
  apt::source { 'sbt':
    location    => 'http://dl.bintray.com/sbt/debian',
    release     => '',
    include_src => false,
    repos       => '/',
  } ->

  package{'sbt':
    ensure  => present
  }
}
