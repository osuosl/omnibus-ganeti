name "python-pycrypto"
default_version "2.6.1"

dependency 'pip'
dependency 'gmp'

pip_install = "embedded/bin/pip install -I --build #{project_dir}"

env = {
  "CFLAGS"  => ["-I#{install_dir}/embedded/include",
                "-I#{install_dir}/embedded/include/openssl",
                "-I#{install_dir}/embedded/include/curl"].join(" "),
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -Wl,-rpath,#{install_dir}/embedded/lib",
  "LD_LIBRARY_PATH" => "-L#{install_dir}/embedded/lib",
  "PATH"    => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  command "#{install_dir}/#{pip_install} pycrypto==#{default_version}", :env => env
end
