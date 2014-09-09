#
# Cookbook Name:: virtualbox
# Recipe:: default
#
# Copyright 2014, Mariani Lucas
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe 'build-essential::default'

version_pkg = node[:virtualbox][:version].split('.').first(2).join('.')

case node[:platform_family]
when 'debian'

  apt_repository 'oracle-virtualbox' do
    uri node[:virtualbox][:url]
    key node[:virtualbox][:gpg]
    distribution node[:lsb][:codename]
    components [:contrib]
  end

  package "virtualbox-#{version_pkg}" do
    action :install
    retries 5
    retry_delay 2
  end

  package 'dkms' do
    action :install
    retries 5
    retry_delay 2
  end

when 'rhel', 'fedora'

  yum_repository 'oracle-virtualbox' do
    description "#{node[:platform_family]} $releasever - $basearch - Virtualbox"
    baseurl node[:virtualbox][:url]
    gpgcheck true
    gpgkey node[:virtualbox][:gpg]
  end

  Chef::Config[:yum_timeout] = node[:virtualbox][:timeout ]

  package "VirtualBox-#{version_pkg}" do
    retries 5
    retry_delay 2
  end
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node[:virtualbox][:extension_name]}" do
  owner 'root'
  group 'root'
  mode '0644'
  source node[:virtualbox][:extension]
  action :create_if_missing
end

execute 'driver_build' do
  user 'root'
  command '/etc/init.d/vboxdrv setup'
  action :run
  not_if "/etc/init.d/vboxdrv status | grep #{version_pkg}"
end

execute 'extpacks_install' do
  user 'root'
  cwd Chef::Config[:file_cache_path]
  command "VBoxManage extpack install #{node[:virtualbox][:extension_name]}"
  action :run
  not_if "VBoxManage list extpacks | grep #{node[:virtualbox][:version]}"
end
