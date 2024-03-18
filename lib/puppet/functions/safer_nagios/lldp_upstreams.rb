Puppet::Functions.create_function(:'safer_nagios::lldp_upstreams') do
  dispatch :lldp_upstreams do
    required_param 'Hash', :lldp_info
    return_type 'Array'
  end

  def lldp_upstreams(lldp_info)
    unless lldp_info.key?('interface')
      return([])
    end

    if lldp_info['interface'].is_a?(Hash)
      lldp_interfaces = [lldp_info['interface']]

    elsif lldp_info['interface'].is_a?(Array)
      lldp_interfaces = lldp_info['interface']

    else
      raise Puppet::ParseError, "Node does not have proper LLDP information: #{lldp_info.class} - #{lldp_info}"
    end

    result = []
    lldp_interfaces.each do |interface|
      interface.each do |_if_name, data|
        unless data.is_a?(Hash)
          raise Puppet::ParseError, "lldp_upstream: unexpected argument type #{data.class}, only expects hash arguments: #{lldp_info}"
        end

        raise Puppet::ParseError, "lldp_upstream: chassis information is missing: #{data}" unless data['chassis']
        result.concat(data['chassis'].keys)
      end
    end

    result
  end
end
