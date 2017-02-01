# Class: lein
# This module manages boot see https://github.com/boot-clj/boot
class build::boot {

  $url = 'https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh'

  exec{'wget boot':
    command => "wget ${url} -O /usr/local/bin/boot",
    user    => 'root',
    path    => ['/usr/bin','/bin',]
  }

  file{'/usr/local/bin/boot':
    mode  => 'a+rwx'
  }

}
