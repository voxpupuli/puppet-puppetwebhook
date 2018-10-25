require 'spec_helper'

describe 'puppetwebhook' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('puppetwebhook::install') }
      it { is_expected.to contain_class('puppetwebhook::config') }
      it { is_expected.to contain_class('puppetwebhook::service') }
      it {
        is_expected.to contain_package('puppet_webhook').with(
          ensure: 'installed',
          provider: 'puppet_gem',
        )
      }
      it {
        is_expected.to contain_file('/etc/puppet_webhook').with(
          ensure: 'directory',
          require: 'Package[puppet_webhook]',
        )
      }
      ['server', 'app'].each do |cfg|
        it {
          is_expected.to contain_file("/etc/puppet_webhook/#{cfg}.yml").with(
            ensure: 'file',
            owner: 'root',
            group: 'puppet_webhook',
            mode: '0640',
          )
        }
      end
    end
  end
end
