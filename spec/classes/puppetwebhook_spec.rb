require 'spec_helper'

describe 'puppetwebhook' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('puppetwebhook::install') }
      it { is_expected.to contain_class('puppetwebhook::config') }
      it { is_expected.to contain_class('puppetwebhook::service') }
      it 'contains webhook package' do
        is_expected.to contain_package('puppet-webhook').with(
          ensure: 'installed',
        )
      end

      it 'contains the config file' do
        is_expected.to contain_file('/etc/voxpupuli/webhook.yaml').with(
          ensure: 'file',
          owner: 'root',
          group: 'root',
          mode: '0644',
        )
      end
    end
  end
end
