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
  service { 'puppet-webhook':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
