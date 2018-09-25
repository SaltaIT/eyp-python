class python::params {

  case $::osfamily
  {
    'redhat':
    {
      $include_epel=true
      $repo_url=undef
      $repo_name=undef
      case $::operatingsystemrelease
      {
        /^[56].*$/:
        {
          $python_pkgs= [ 'python', 'python-pip' ]
        }
        /^7.*$/:
        {
          $python_pkgs= [ 'python', 'python2-pip' ]
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $include_epel=false
      $repo_url=undef
      $repo_name=undef
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^1[468].*$/:
            {
              $python_pkgs= [ 'python', 'python-pip' ]
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    'Suse':
    {
      case $::operatingsystem
      {
        'SLES':
        {
          case $::operatingsystemrelease
          {
            /^11.[34]$/:
            {
              $repo_url='http://download.opensuse.org/repositories/devel:/languages:/python/SLE_11_SP4/devel:languages:python.repo'
              $repo_name='Python Modules (SLE_11_SP4)'
              $python_pkgs= [ 'python', 'python-pip' ]
            }
            /^12.3$/:
            {
              $repo_url=undef
              $repo_name=undef
              $python_pkgs= [ 'python', 'python-pip' ]
            }
            default: { fail("Unsupported operating system ${::operatingsystem} ${::operatingsystemrelease}") }
          }
        }
        default: { fail("Unsupported operating system ${::operatingsystem}") }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
