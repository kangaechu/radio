#
# Cookbook Name:: radio
# Attributes:: default
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

default["radio"]["user"] = "ubuntu"

default["radio"]["bindir"] = "/home/" + node["radio"]["user"] + "/bin"
default["radio"]["workdir"] = "/home/" + node["radio"]["user"] + "/work/radio"
default["radio"]["destdir"] = "/home/" + node["radio"]["user"] + "/Dropbox/Radio"

case node['platform_family']
when 'debian'
  default['radio']['packages'] = %w[
    perl wget swftools rtmpdump libav-tools libmp3lame0 libavcodec-extra-53 python-gpgme liblocal-lib-perl
  ]
when "rhel"
  default['radio']['packages'] = %w[
   perl wget swftools rtmpdump libav-tools libmp3lame0 libavcodec-extra-53 python-gpgme
  ]
else
  default['radio']['packages'] = %w[
   perl wget swftools rtmpdump libav-tools libmp3lame0 libavcodec-extra-53 python-gpgme
  ]
end