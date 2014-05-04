name "gmp"
default_version "5.1.3"

version "5.1.3" do
  source md5: "4df82299c8dee6697d22f3bb0d0909b0"
end

version "4.3.2" do
  source md5: "2a431d487dfd76d0f618d241b1e551cc"
end

source url: "ftp://mirrors.kernel.org/gnu/gmp/gmp-#{version}.tar.gz"

relative_path "gmp-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make install", :env => env
end
