require 'spec_helper'

describe 'Puppetwebhook::Serverconfig' do
  let(:pre_condition) { 'include stdlib' }

  serverconfig = {
    'server_type' => 'simple',
    'host' => '0.0.0.0',
    'logfile' => '/foo/bar/log',
    'loglevel' => 'WARN',
    'pidfile' => '/foo/bar/pidfile',
    'port' => 80,
    'enable_ssl' => true,
    'ssl_verify' => true,
    'ssl_cert' => '/foo/bar/cert',
    'ssl_key' => '/foo/bar/key',
  }

  it { is_expected.to allow_value(serverconfig) }
end
