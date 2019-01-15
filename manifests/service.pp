# This class sets up the SystemD service file, performs a daemon reload,
# enables and starts the webhook service.
#
# @summary Manage the webhook service
#
# @author Vox Pupuli <voxpupuli@groups.io>
#
# @api private
#
class puppetwebhook::service {
  include systemd

  systemd::unit_file { 'puppet_webhook.service':
    ensure  => 'present',
    content => epp('puppetwebhook/puppet_webhook.service.epp', {
        'user'        => $puppetwebhook::webhook_user,
        'webhook_bin' => $puppetwebhook::binfile,
        'env_path'    => $puppetwebhook::envfile_path,
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
