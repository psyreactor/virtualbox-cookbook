require 'spec_helper'

describe 'virtualbox::default' do
  context 'on Centos 6.4 x86_64 with virtualbox 4.3' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'centos', version: 6.4, step_into: ['yum_repository']) do |node|
        node.automatic['kernel']['machine'] = 'x86_64'
        node.default['virtualbox']['version'] = '4.3.12'
      end.converge(described_recipe)
    end

    before do
      stub_command('/etc/init.d/vboxdrv status | grep 4.3').and_return(false)
      stub_command('VBoxManage list extpacks | grep 4.3.12').and_return(false)
    end

    it 'include recipe build-essential' do
      expect(chef_run).to include_recipe('build-essential::default')
    end

    it 'creates repository with oracle-virtualbox' do
      expect(chef_run).to create_yum_repository('oracle-virtualbox').with(url: 'http://download.virtualbox.org/virtualbox/rpm/rhel/$releasever/$basearch')
    end

    it 'install packages required for virtualbox' do
      expect(chef_run).to install_package('VirtualBox-4.3')
    end

    it 'download a virtualbox extpack' do
      expect(chef_run).to create_remote_file_if_missing("#{Chef::Config[:file_cache_path]}/Oracle_VM_VirtualBox_Extension_Pack-4.3.12.vbox-extpack")
    end

    it 'execute build vboxdrv' do
      expect(chef_run).to run_execute('driver_build')
    end

    it 'execute extpack install' do
      expect(chef_run).to run_execute('extpacks_install')
    end

  end
end
