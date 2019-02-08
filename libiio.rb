
class Libiio < Formula
  desc "libIIO"
  homepage "https://github.com/analogdevicesinc/iio-oscilloscope/wiki"
#  head "https://github.com/analogdevicesinc/libiio.git"
  url "https://github.com/analogdevicesinc/libiio/archive/v0.17.tar.gz"

  # libusb libxml2
  depends_on "cmake" => :build
#  depends_on "gtk+" => :build
#  depends_on "glib" => :build
#  depends_on "libcdk5-dev" => :build
#  depends_on "bison" => :build
#  depends_on "flex" => :build
  depends_on "doxygen" => build
  depends_on "libxml2" => :build
  depends_on "libusb" => :build

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
