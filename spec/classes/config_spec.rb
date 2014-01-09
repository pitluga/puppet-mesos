require 'spec_helper'

describe 'mesos::config' do

  let(:owner) { 'mesos' }
  let(:group) { 'mesos' }

  let(:params){{
    :conf_dir => '/etc/mesos',
    :log_dir  => '/var/log/mesos',
    :owner    => owner,
    :group    => group,
  }}

  it { should contain_file('/etc/default/mesos').with({
    'ensure'  => 'present',
    'owner'   => owner,
    'group'   => group,
    'mode'    => '0644',
    'require' => 'Package[mesos]',
  }) }

  it 'has default log dir' do
    should contain_file(
      '/etc/default/mesos'
    ).with_content(/LOGS="\/var\/log\/mesos"/)
  end

  it 'has default ulimit' do
    should contain_file(
      '/etc/default/mesos'
    ).with_content(/ULIMIT="-n 8192"/)
  end

  context 'no zookeeper servers' do
    it 'has empty zk file in config dir' do
      should contain_file(
        '/etc/mesos/zk'
      ).with_content("\n")
    end
  end

  context 'with zookeeper serers' do
    let(:zookeeper) { 'zk://localhost:2181/mesos' }
    let(:params){{
      :zookeeper => zookeeper
    }}

    it 'has zk file in config dir' do
      should contain_file(
        '/etc/mesos/zk'
      ).with_content(/#{zookeeper}/)
    end
  end

  context 'setting ulimit' do
    let(:params){{
      :ulimit => 16384,
    }}

    it { should contain_file(
      '/etc/default/mesos'
      ).with_content(/ULIMIT="-n 16384"/)
    }
  end

  context 'setting log dir' do
    let(:params){{
      :log_dir => '/srv/mesos/log',
    }}
    it { should contain_file(
      '/etc/default/mesos'
      ).with_content(/LOGS="\/srv\/mesos\/log"/)
    }
  end
end
