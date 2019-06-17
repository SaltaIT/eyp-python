class python(
              $manage_package = true,
              $manage_config  = true,
              $pip_index_url  = undef,
              $pip_timeout    = undef,
            ) inherits python::params {

  class { '::python::install': } ->
  class { '::python::config': } ->
  Class['::python']
}
