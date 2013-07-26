#
# Cookbook Name:: radio
# Recipe:: default
#
# Copyright 2013, kangaechu.com
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

Encoding.default_external = Encoding::UTF_8

# 1. Packages / Dependencies
%w{ perl wget swftools rtmpdump libav-tools libmp3lame0}.each do |package_name|
  package package_name do
    action :install
  end
end

cpan_client 'DateTime' do
  action 'install'
  install_type 'cpan_module'
  user 'root'
  group 'root'
end

# 2. creating directories
directory node[:radio][:bindir] do
  owner node[:radio][:user]
  group node[:radio][:user]
  mode "0755"
  recursive true
  action :create
end

directory node[:radio][:workdir] do
  owner node[:radio][:user]
  group node[:radio][:user]
  mode "0755"
  recursive true
  action :create
end

directory node[:radio][:destdir] do
  owner node[:radio][:user]
  group node[:radio][:user]
  mode "0755"
  recursive true
  action :create
end

# 3. copying bin files.
%w{ encodeRadio.pl radiko.sh radiru.sh }.each do |script_name|
  template "#{node[:radio][:bindir]}/#{script_name}" do
    source "#{script_name}.erb"
    owner node[:radio][:user]
    group node[:radio][:user]
    mode "0755"
  end
end

#5. backup and override crontab
execute "override user crontab" do
  command "crontab < #{node[:radio][:bindir]}/crontab.txt"
  user node[:radio][:user]
  group node[:radio][:user]
  action :nothing
end

execute "backup user crontab" do
  command "crontab -l > #{node[:radio][:workdir]}/crontab-`date +%Y%m%d-%H%M%S`.txt"
  user node[:radio][:user]
  group node[:radio][:user]
  returns [0, 1]
  action :nothing
  notifies :run, "execute[override user crontab]", :immediately
end


#4. copying data files.
cookbook_file "#{node[:radio][:bindir]}/progData.txt" do
  source "progData.txt"
  owner node[:radio][:user]
  group node[:radio][:user]
  mode "0644"
end

cookbook_file "#{node[:radio][:bindir]}/crontab.txt" do
  source "crontab.txt"
  owner node[:radio][:user]
  group node[:radio][:user]
  mode "0644"
  notifies :run, "execute[backup user crontab]", :immediately
end

