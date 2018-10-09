require 'spec_helper_acceptance'

describe 'puppetwebhook' do
  it 'applies' do
    pp = <<-MANIFEST
    class { 'puppetwebhook': }
    MANIFEST

    apply_manifest(pp, catch_failures: true)
  end
end
