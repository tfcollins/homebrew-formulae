class GrIio < Formula
  include Language::Python::Virtualenv

  desc "IIO blocks for GNU Radio"
  homepage "https://wiki.analog.com/resources/tools-software/linux-software/gnuradio"
  license "GPL-3.0"
  head "https://github.com/analogdevicesinc/gr-iio.git", branch: "upgrade-3.8"

  depends_on "bison" => :build
  depends_on "cmake" => :build
  depends_on "flex" => :build
  depends_on "pkg-config" => :build
  depends_on "swig" => :build

  depends_on "boost"
  depends_on "fftw"
  depends_on "gmp"
  depends_on "gnuradio"
  depends_on "libad9361-iio"
  depends_on "libiio"
  depends_on "log4cpp"
  depends_on "orc"
  depends_on "python@3.9"
  depends_on "volk"

  # CMake does not detect this dependency correctly
  depends_on "mpir" => :optional

  # This patch has not yet made it into the GNU Radio 3.8-compatible branch
  # https://github.com/analogdevicesinc/gr-iio/pull/90
  patch do
    url "https://github.com/analogdevicesinc/gr-iio/commit/c35a071cb006d5bf1a0416422113b9a45ec96daa.patch?full_index=1"
    sha256 "1004ada83fac0813076b881eabfa5aaaf703a090076c4b69400f0addcfdac1f8"
  end

  def install
    # Create a Python virtual environment into which we install our module
    # https://docs.brew.sh/Python-for-Formula-Authors
    venv_root = libexec/"venv"
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH", "#{venv_root}/lib/python#{xy}/site-packages"
    virtualenv_create(venv_root, "python3")

    mkdir "build" do
      cmake_args = [
        "-DPYTHON_EXECUTABLE=#{venv_root}/bin/python",
      ]
      system "cmake", "..", *cmake_args, *std_cmake_args
      system "make"
      system "make", "install"
    end

    # Leave a pointer to our Python module directory where GNU Radio can find it
    site_packages = lib/"python#{xy}/site-packages"
    pth_contents = "#{site_packages}\n"
    (etc/"gnuradio/plugins.d/gr-iio.pth").write pth_contents
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <iio/math.h>
      int main() {
        gr::iio::iio_math::make("0");
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "-L#{lib}", "-lgnuradio-iio", "-o", "test", "test.cpp"
    system "./test"

    # Make sure GNU Radio's Python can find our module
    (testpath/"testimport.py").write "import iio\n"
    system Formula["gnuradio"].libexec/"venv/bin/python", testpath/"testimport.py"
  end
end
