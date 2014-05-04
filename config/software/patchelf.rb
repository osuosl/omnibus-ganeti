name "patchelf"
default_version "0.8"

source :url => "http://releases.nixos.org/patchelf/patchelf-#{default_version}/patchelf-#{default_version}.tar.gz",
       :md5 => "407b229e6a681ffb0e2cdd5915cb2d01"

relative_path "patchelf-#{default_version}"

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
