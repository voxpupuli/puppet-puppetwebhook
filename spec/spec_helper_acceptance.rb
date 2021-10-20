require 'voxpupuli/acceptance/spec_helper_acceptance'

configure_beaker do |host|
  install_module_from_forge_on(host, 'puppet-redis', '>= 6.1.0 < 9.0.0')
  case fact_on(host, 'os.family')
  when 'Debian'
    install_module_from_forge_on(host, 'puppetlabs-apt', '>= 8.0.0 < 9.0.0')
    install_package(host, 'build-essential')
  when 'RedHat'
    install_module_from_forge_on(host, 'puppet-yum', '>= 5.2.0 < 6.0.0')
    install_package(host, 'epel-release')
  end
end
