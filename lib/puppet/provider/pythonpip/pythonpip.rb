Puppet::Type.type(:pythonpip).provide(:pythonpip) do
  desc 'pip'

  commands :pip => '/usr/bin/pip'

  if Puppet::Util::Package.versioncmp(Puppet.version, '3.0') >= 0
    has_command(:pip, '/usr/bin/pip') do
      is_optional
      environment :HOME => "/root"
    end
  end

  #nota: si peta amb centos treure la coma final de package
  def self.instances
    pip(['list']).scan(/^([^ ]+) \([0-9\.]*\)/).collect do |package|
      debug "package \""+package[0]+"\""
      new(
        :ensure => :present,
        :name => package[0]
        )
    end
  end

  def self.prefetch(resources)
    resources.keys.each do |name|
      if provider = instances.find{ |db| db.name == name }
        resources[name].provider = provider
      end
    end
  end

  def exists?
    @property_hash[:ensure] == :present || false
  end

  def create
    debug "call create()"
    pip(['install', resource[:name] ])
  end

  def destroy
    debug "call destroy()"
    pip(['uninstall', resource[:name] ])
  end

end
