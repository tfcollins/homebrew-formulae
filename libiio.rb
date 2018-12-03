
class Libiio < Formula
  desc "libIIO"
  homepage "https://github.com/analogdevicesinc/iio-oscilloscope/wiki"
  head "https://github.com/analogdevicesinc/libiio.git"

  # lib-2.0 gtk+-2.0 gthread-2.0 gtkdatabox fftw3 libiio libxml-2.0 libcurl jansson
  depends_on "cmake" => :build
  depends_on "gtk+" => :build
  depends_on "glib" => :build
  depends_on "libxml2" => :build
  depends_on "libxml2-dev" => :build
  depends_on "bison" => :build
  depends_on "flex" => :build
  depends_on "libcdk5-dev" => :build

  def install
    ENV.deparallelize  # if your formula fails when building in parallel
    system "mkdir build"
    system "cd build"
    system "pwd"
    system "cmake .."
    system "make"
    #system "make","DESTDIR=#{prefix}","install-common-files"
  end

  test do
    system "false"
  end
end
