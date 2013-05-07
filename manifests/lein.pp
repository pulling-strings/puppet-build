# Class: lein
#
# This module manages lein see https://github.com/technomancy/leiningen
# Requires:
#  Java installed
# [Remember: No empty lines between comments and class definition]
class build::lein {

  $lein_url = 'https://raw.github.com/technomancy/leiningen/preview/bin/lein'

  package{'openjdk-6-jdk':
    ensure  => present
  }

  apt::source { 'narkisr-debs':
    location    => 'http://dl.bintray.com/content/narkisr/narkisr-debs',
    repos       => '/',
    release     => '',
    include_src => false,
  } ->

  package{ 'leiningen':
    ensure   => installed,
    require  => Class['jdk']
  }

}
