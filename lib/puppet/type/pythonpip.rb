Puppet::Type.newtype(:pythonpip) do
  @doc = 'Manage python-pip packages'

  ensurable

  autorequire(:package) do
    'python-pip'
  end

  newparam(:index_url, :namevar => false) do
    desc "PIP mirror to use"
  end

  #--trusted-host
  newparam(:trusted_host, :namevar => false) do
    desc "set if this mirror is trusted"
  end

  newparam(:name, :namevar => true) do
    desc 'package to manage'

    validate do |value|
      unless value.is_a?(String)
        raise Pupper::Error,
          "not a string, modafuca"
      end
    end
  end
end
