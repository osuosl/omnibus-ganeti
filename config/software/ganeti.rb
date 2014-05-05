name "ganeti"
default_version "2.11.0"

version "2.11.0" do
  source md5: "2c186d48b56b7d4083161c241f91febe"
end

version "2.10.3" do
  source md5: "7c59fc1be2188d248739a829b5deb002"
end

version "2.9.6" do
  source md5: "ff2943bc3dc38d03f3a4ffbcf3b31b4e"
end

version "2.8.4" do
  source md5: "6d9ddb5a9645a3d57a4f90dd92677bcc"
end

source url: "http://downloads.ganeti.org/releases/#{default_version[/\d.\d+/]}/ganeti-#{default_version}.tar.gz"

relative_path "ganeti-#{default_version}"

dependency 'python'
dependency 'ganeti-common'

configure = ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--enable-symlinks",
           "--localstatedir=#{install_dir}/var",
           "--sysconfdir=#{install_dir}/etc"].join(" ")

sed = ["sed -i -e 's/\\!\\/usr/\\!\\/opt\\/ganeti\\/embedded/'",
       "autotools/build-bash-completion",
       "Makefile"].join(" ")

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  command configure, :env => env
  command sed
  command "make -j #{max_build_jobs}", :env => env
  command "make install", :env => env
end
