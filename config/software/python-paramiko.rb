name "python-paramiko"
default_version "1.14.0"

dependency 'pip'
dependency 'python-pycrypto'

pip_install = "embedded/bin/pip install -I --build #{project_dir}"

env = {
  "CFLAGS"  => ["-I#{install_dir}/embedded/include",
                "-I#{install_dir}/embedded/include/openssl",
                "-I#{install_dir}/embedded/include/curl"].join(" "),
  "LDFLAGS" => "-L#{install_dir}/embedded/lib",
  "PATH"    => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  command "#{install_dir}/#{pip_install} paramiko==#{default_version}", :env => env
end
