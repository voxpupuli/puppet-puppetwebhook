# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include puppetwebhook::config
class puppetwebhook::config {
  assert_private()

  file {
    default:
      owner => 'root',
      group => 'root',
      ;
    '/etc/puppet_webhook':
      ensure  => directory,
      require => Package['puppet_webhook'],
      ;
    '/etc/puppet_webhook/server.yml':
      ensure  => file,
      mode    => '0644',
      content => to_yaml($puppetwebhook::server_cfg),
      #notify  => Service['puppet_webhook'],
      ;
    '/etc/puppet_webhook/app.yml':
      ensure  => file,
      mode    => '0644',
      content => to_yaml($puppetwebhook::app_cfg),
      #notify  => Service['puppet_webhook'],
      ;
  }
}
