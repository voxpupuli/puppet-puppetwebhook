require 'spec_helper'

describe 'puppetwebhook' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('puppetwebhook::install') }
      it { is_expected.to contain_class('puppetwebhook::config') }
      it { is_expected.to contain_package('puppet_webhook').with_provider('puppet_gem') }
      it { is_expected.to contain_file('/etc/puppet_webhook').with_ensure('directory') }
      it { is_expected.to contain_file('/etc/puppet_webhook/server.yml').with_ensure('file') }
      it { is_expected.to contain_file('/etc/puppet_webhook/app.yml').with_ensure('file') }
    end
  end
end
