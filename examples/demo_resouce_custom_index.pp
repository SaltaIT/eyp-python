include ::python

pythonpip { 'nagiosplugin':
  ensure    => 'present',
  index_url => 'http://pipmirror.cm.nttcom.ms',
}
