class python(
              $manage_package = true,
            ) inherits python::params {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  if($manage_package)
  {
    if($python::params::include_epel)
    {
      include ::epel

      Package[$python::params::python_pkgs] {
        require => Class['epel'],
      }
    }

    if($python::params::repo_url!=undef)
    {
      if($python::params::repo_url =~ /suse/)
      {
        #zypper ar
        exec { 'install repo suse':
          command => "zypper ar ${python::params::repo_url}",
          unless  => "zypper lr | grep '${python::params::repo_name}'",
          before  => Package[$python::params::python_pkgs],
        }

      }
    }

    package { $python::params::python_pkgs:
      ensure => 'installed',
    }

    # /usr/bin/pip /usr/bin/pip-python
    file { '/usr/bin/pip-python':
      ensure  => 'link',
      target  => '/usr/bin/pip',
      require => Package[$python::params::python_pkgs],
    }
  }
}
