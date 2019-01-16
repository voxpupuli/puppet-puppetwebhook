require 'spec_helper_acceptance'

describe 'puppetwebhook' do
  it 'applies' do
    pp = <<-MANIFEST
    class { 'puppetwebhook': }
    MANIFEST

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe package('puppet_webhook') do
    let(:path) { '$PATH:/opt/puppetlabs/puppet/bin' }

    it { is_expected.to be_installed.by('gem') }
  end

  describe group('puppet_webhook') do
    it { is_expected.to exist }
  end

  describe user('puppet_webhook') do
    it { is_expected.to exist }
    it { is_expected.to belong_to_primary_group('puppet_webhook') }
  end

  describe file('/etc/puppet_webhook') do
    it { is_expected.to be_directory }
  end

  describe file('/etc/puppet_webhook/server.yml') do
    it { is_expected.to be_file }
    it { is_expected.to be_owned_by('root') }
    it { is_expected.to be_grouped_into('puppet_webhook') }
    it { is_expected.to be_mode(640) }
    its(:content_as_yaml) do
      is_expected.to include(
        'server_type' => 'simple',
        'host' => '0.0.0.0',
        'logfile' => '/etc/puppet_webhook/webhook.log',
        'loglevel' => 'WARN',
        'pidfile' => '/var/run/puppet_webhook.pid',
        'port' => 8088,
        'enable_ssl' => false,
      )
    end
  end

  describe file('/etc/puppet_webhook/app.yml') do
    it { is_expected.to be_file }
    it { is_expected.to be_owned_by('root') }
    it { is_expected.to be_grouped_into('puppet_webhook') }
    it { is_expected.to be_mode(640) }
    its(:content_as_yaml) do
      is_expected.to include(
        'protected' => true,
        'user' => 'root',
        'pass' => 'puppet',
        'use_mcollective' => false,
        'chatops' => false,
        'default_branch' => 'production',
        'r10k_deploy_arguments' => '-pv',
        'command_prefix' => '0022',
      )
    end
  end

  describe service('puppet_webhook') do
    it { is_expected.to be_running }
  end

  if os[:family] =~ %r{(redhat|suse)}
    describe file('/etc/sysconfig/puppet_webhook') do
      it { is_expected.to be_file }
    end
  elsif os[:family] == 'debian'
    describe file('/etc/default/puppet_webhook') do
      it { is_expected.to be_file }
    end
  end
end
