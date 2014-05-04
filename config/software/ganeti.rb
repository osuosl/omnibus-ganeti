name "ganeti"
default_version "2.11.0"

source :url => "http://downloads.ganeti.org/releases/2.11/ganeti-#{default_version}.tar.gz",
       :md5 => "2c186d48b56b7d4083161c241f91febe"

relative_path "ganeti-#{default_version}"

dependency 'python'
dependency 'ganeti-common'

configure = ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--localstatedir=#{install_dir}/var",
           "--sysconfdir=#{install_dir}/etc"].join(" ")

sed = ["sed -i -e 's/\\!\\/usr/\\!\\/opt\\/ganeti\\/embedded/'",
       "autotools/build-bash-completion"].join(" ")

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
