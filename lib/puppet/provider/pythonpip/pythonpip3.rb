Puppet::Type.type(:pythonpip3).provide(:pythonpip3) do
  desc 'pip'

  commands :pip => '/usr/bin/pip3'

  if Puppet::Util::Package.versioncmp(Puppet.version, '3.0') >= 0
    has_command(:pip, '/usr/bin/pip3') do
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
    install_cmd = []
    install_cmd.push('install')
    install_cmd.push("--index-url", resource[:index_url]) if resource[:index_url]
    install_cmd.push("--trusted-host", resource[:trusted_host]) if resource[:trusted_host]

    if resource[:file]
      install_cmd.push(resource[:file])
    else
      install_cmd.push(resource[:name])
    end

    pip(install_cmd)
  end

  def destroy
    debug "call destroy()"
    pip(['uninstall', resource[:name] ])
  end

end
