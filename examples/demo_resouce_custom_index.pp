include ::python

pythonpip { 'penisipsum':
  ensure       => 'present',
}

pythonpip { 'nagiosplugin':
  ensure       => 'present',
  index_url    => 'http://pipmirror.cm.nttcom.ms',
  trusted_host => 'pipmirror.cm.nttcom.ms',
}
