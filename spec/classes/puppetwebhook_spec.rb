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
        is_expected.to contain_package('puppet_webhook').with(
          ensure: 'installed',
          provider: 'puppet_gem'
        )
      end
      context 'when pkg_version is specified' do
        let(:params) { { 'pkg_version' => '1.6.2' } }

        it 'installs the correct version' do
          is_expected.to contain_package('puppet_webhook').with_ensure('1.6.2')
        end
      end

      it 'contains webhook dir' do
        is_expected.to contain_file('/etc/puppet_webhook').with(
          ensure: 'directory',
          require: 'Package[puppet_webhook]'
        )
      end

      it 'contains env file' do
        case facts[:os]['family']
        when 'Debian'
          is_expected.to contain_file('/etc/default/puppet_webhook')
        when %r{(RedHat|Suse)}
          is_expected.to contain_file('/etc/sysconfig/puppet_webhook')
        end
      end

      %w[server app].each do |cfg|
        it "contains #{cfg} file" do
          is_expected.to contain_file("/etc/puppet_webhook/#{cfg}.yml").with(
            ensure: 'file',
            owner: 'root',
            group: 'puppet_webhook',
            mode: '0640'
          )
        end
      end
    end
  end
end
