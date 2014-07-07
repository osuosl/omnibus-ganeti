name "ganeti"
version = ENV['GANETI_VERSION'] || '2.11.2'
default_version "#{version}"

version "2.11.2" do
  source md5: "c89c5e74feb57b1b377755fe7a9b2ade"
end

version "2.10.6" do
  source md5: "1d48496ce4afc762fd2fe5efb2b0f925"
end

version "2.9.6" do
  source md5: "ff2943bc3dc38d03f3a4ffbcf3b31b4e"
end

version "2.8.4" do
  source md5: "6d9ddb5a9645a3d57a4f90dd92677bcc"
end

if version =~ /^\d/
  source url: "http://downloads.ganeti.org/releases/#{default_version[/\d.\d+/]}/ganeti-#{default_version}.tar.gz"
else
  source git: "git://git.ganeti.org/ganeti.git"
end

relative_path "ganeti-#{default_version}"

dependency 'python'
dependency 'ganeti-common'
if version !~ /^\d/
  dependency 'python-sphinx'
end

configure = ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--enable-symlinks",
           "--localstatedir=#{install_dir}/var",
           "--sysconfdir=#{install_dir}/etc"].join(" ")

sed_python = "sed -i -e 's/\\!\\/usr/\\!\\/opt\\/ganeti\\/embedded/'"
sed_werror = "sed -i -e 's/\\-Werror\\(,\\|\\)//'"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  if version !~ /^\d/
    command "./autogen.sh"
  end
  # Cleanup hard-coded python paths
  command "#{sed_python} autotools/* Makefile*"
  # Remove Werror on Debian builds
  command "#{sed_werror} Makefile*"
  command configure, :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make install", :env => env
  command "mkdir -p #{install_dir}/etc/init.d"
  command "mkdir -p #{install_dir}/etc/cron.d"
  command "cp doc/examples/ganeti.initd #{install_dir}/etc/init.d/ganeti"
  command "cp doc/examples/ganeti.cron #{install_dir}/etc/cron.d/ganeti.cron"
  command "chmod +x #{install_dir}/etc/init.d/ganeti"
end
