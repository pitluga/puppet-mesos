require 'spec_helper'

describe 'mesos::install' do

  context 'with given version' do
    let(:version) { '0.14' }
    let(:params) {{
      :ensure => version,
      :install_python => true
    }}

    it { should contain_package('mesos').with({
      'ensure' => version
    }) }

    # mesos dependencies (for web GUI)
    it { should contain_package('python').with({
      'ensure' => 'present'
    }) }
  end

  context 'without installing python' do
    let(:install_python) { false }
    let(:params) {{
      :ensure => 'present',
      :install_python => install_python
    }}

    it { should contain_package('mesos').with({
      'ensure' => 'present'
    }) }

    it { should_not contain_package('python') }
  end
end
