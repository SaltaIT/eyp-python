class python(
              $manage_package = true,
              $manage_config  = true,
            ) inherits python::params {
  class { '::python::install': } ->
  class { '::python::config': } ->
  Class['::python']
}
