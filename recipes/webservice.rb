#
# Cookbook Name:: virtualbox
# Recipe:: webservice
#
# Copyright 2012, Ringo De Smet
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

user node[:virtualbox][:user] do
  gid node[:virtualbox][:group]
  password node[:virtualbox][:password]
  home "/home/#{node[:virtualbox][:user]}"
  shell '/bin/bash'
  system true
  manage_home true
end

template '/etc/vbox/vbox.cfg' do
  source 'vbox.cfg.erb'
end

directory node[:virtualbox][:webservice][:log][:location] do
  owner node[:virtualbox][:user]
  group node[:virtualbox][:group]
  mode '0755'
end

execute 'vboxwebsrv_auth' do
  cwd "/home/#{node[:virtualbox][:user]}"
  command 'VBoxManage setproperty websrvauthlibrary null'
  user node[:virtualbox][:user]
  action :run
  environment 'HOME' => "/home/#{node[:virtualbox][:user]}"
end

service 'vboxweb-service' do
  action [:enable, :start]
end
