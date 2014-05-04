name "ndisc6"
default_version "1.0.2"

source :url => "http://www.remlab.net/files/ndisc6/ndisc6-#{default_version}.tar.bz2",
       :md5 => "50cb4c19606cf6ff2b7388e71832f579"

relative_path "ndisc6-#{default_version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make install", :env => env
end
