#
# Cookbook Name:: virtualbox
# Attributes:: default
#
# Copyright 2011, Joshua Timberman
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

default[:virtualbox][:timeout] = 3_000
default[:virtualbox][:base_url] = 'http://download.virtualbox.org/virtualbox'
default[:virtualbox][:version] = '4.3.12'
default[:virtualbox][:extension_name] = "Oracle_VM_VirtualBox_Extension_Pack-#{node[:virtualbox][:version]}.vbox-extpack"
default[:virtualbox][:extension] = "#{node[:virtualbox][:base_url]}/#{node[:virtualbox][:version]}/#{node[:virtualbox][:extension_name]}"
default[:virtualbox][:gpg] = "#{node[:virtualbox][:base_url]}/debian/oracle_vbox.asc"

case node[:platform_family]
when 'debian'
  default[:virtualbox][:url] = "#{node[:virtualbox][:base_url]}/debian"
when 'rhel', 'fedora'
  default[:virtualbox][:url] = "#{node[:virtualbox][:base_url]}/rpm/#{node[:platform_family]}/$releasever/$basearch"
end
