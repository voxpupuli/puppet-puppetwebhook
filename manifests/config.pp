# This class configures the puppet_webhook API server.
#
# @summary Configures puppet_webhook API server.
#
# @author Vox Pupuli <voxpupuli@groups.io>
#
# @api private
#
class puppetwebhook::config {
  assert_private()

  file { '/etc/voxpupuli/webhook.yaml':
    ensure  => 'file',
    mode    => '0644', # 0644 instead of 0600 until we know if sidekiq needs to read it
    owner   => 'root',
    group   => 'root',
    content => to_yaml($puppetwebhook::app_cfg),
  }
}
