# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include puppetwebhook::service
class puppetwebhook::service {
  include systemd

  systemd::unit_file { 'puppet_webhook.service':
    ensure  => 'present',
    content => epp('puppetwebhook/puppet_webhook.service.epp', {
        'user'            => $puppetwebhook::app_cfg['user'],
        'webhook_bin'     => $puppetwebhook::binfile,
        'webhook_pidfile' => $puppetwebhook::server_cfg['pidfile']
      }
    ),
  }

  service { 'puppet_webhook':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [
      Package['puppet_webhook'],
      Systemd::Unit_file['puppet_webhook.service'],
    ],
  }
}
