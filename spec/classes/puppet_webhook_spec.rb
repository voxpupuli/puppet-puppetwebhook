require 'spec_helper'

describe 'puppet_webhook' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('puppet_webhook::install') }
      it { is_expected.to contain_package('puppet_webhook').with_provider('puppet_gem') }
    end
  end
end
