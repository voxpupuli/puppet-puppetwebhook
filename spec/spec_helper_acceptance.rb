require 'beaker-rspec'
require 'beaker-puppet'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'

RSpec.configure do |c|
  # Configure all nodes in nodeset
  c.before :suite do
    install_module_on(hosts)
    install_module_dependencies_on(hosts)
    hosts.each do |host|
      case fact('os.family')
      when 'Debian'
        install_module_from_forge_on(host, 'puppetlabs-apt', '>= 7.5.0 < 8.0.0')
      when 'RedHat'
        install_package(host, 'epel-release')
      end
      install_module_from_forge_on(host, 'puppet-redis', '>= 6.0.0 < 7.0.0')
    end
  end
end
