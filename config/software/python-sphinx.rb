name "python-sphinx"
default_version "1.2.2"

dependency 'pip'

pip_install = "embedded/bin/pip install -I --build #{project_dir}"

env = {
  "CFLAGS"  => ["-I#{install_dir}/embedded/include",
                "-I#{install_dir}/embedded/include/openssl",
                "-I#{install_dir}/embedded/include/curl"].join(" "),
  "LDFLAGS" => "-L#{install_dir}/embedded/lib",
  "PATH"    => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  command "#{install_dir}/#{pip_install} sphinx==#{default_version}", :env => env
end
