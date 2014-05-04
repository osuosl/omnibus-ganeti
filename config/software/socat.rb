name "socat"
default_version "1.7.2.4"

source :url => "http://www.dest-unreach.org/socat/download/socat-#{default_version}.tar.gz",
       :md5 => "2a15dc3362f49d543abdbacc267d0a41"

relative_path "socat-#{default_version}"

configure = ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--disable-readline"].join(" ")

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  command configure, :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make install", :env => env
end
