name "fping"
default_version "3.10"

source :url => "http://fping.org/dist/fping-#{default_version}.tar.gz",
       :md5 => "6a0ddecb671df1d580d20c0dd1095773"

relative_path "fping-#{default_version}"

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
