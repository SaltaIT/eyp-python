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
          $set_alternative_python=undef
          $set_alternative_pip=undef
        }
        /^7.*$/:
        {
          $python_pkgs= [ 'python', 'python2-pip' ]
          $set_alternative_python=undef
          $set_alternative_pip=undef
        }
        /^8.*$/:
        {
          $python_pkgs= [ 'python3', 'python3-pip' ]
          $set_alternative_python='/usr/bin/python3'
          $set_alternative_pip='/usr/bin/pip3'
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $include_epel=false
      $repo_url=undef
      $repo_name=undef
      $set_alternative_python=undef
      $set_alternative_pip=undef
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
      $include_epel=false
      $set_alternative_python=undef
      $set_alternative_pip=undef
      case $::operatingsystem
      {
        'SLES':
        {
          #http://ftp1.nluug.nl/os/Linux/distr/opensuse/repositories/openSUSE:/infrastructure/SLE_11_SP4/x86_64/python-pip-9.0.1-3.1.x86_64.rpm
          case $::operatingsystemrelease
          {
            /^11.[34]$/:
            {
              # $repo_url='http://download.opensuse.org/repositories/devel:/languages:/python/SLE_11_SP4/devel:languages:python.repo'
              # $repo_name='Python Modules (SLE_11_SP4)'
              $repo_url=undef
              $repo_name=undef
              $python_pkgs= [ 'python', 'python-pip' ]
            }
            /^12.[34]/:
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
