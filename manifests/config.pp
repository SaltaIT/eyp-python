class python::config inherits python {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  if($python::params::set_alternative_python!=undef)
  {
    alternatives::set { 'python':
      path => $python::params::set_alternative_python,
    }
  }

  if($python::params::set_alternative_pip!=undef)
  {
    alternatives::set { 'pip':
      path => $python::params::set_alternative_pip,
    }
  }

  if($python::manage_config)
  {
    exec { 'mkdir home pip config':
      command => 'mkdir -p /root/.pip',
      creates => '/root/.pip',
    }

    # On Unix and Mac OS X the configuration file is: $HOME/.pip/pip.conf
    file { '/root/.pip/pip.conf':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0750',
      require => Exec['mkdir home pip config'],
    }
  }

}
