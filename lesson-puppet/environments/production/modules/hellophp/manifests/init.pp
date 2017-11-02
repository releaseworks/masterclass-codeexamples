class hellophp {
    class { 'apache': 
        mpm_module => 'prefork',
    }

    include apache::mod::php

    file { '/var/www/html/index.html':
        ensure  => absent
    }

    file { '/var/www/html/index.php':
        ensure  => file,
        source  => 'puppet:///modules/hellophp/index.php',
        mode    => '0644',
   }

}
