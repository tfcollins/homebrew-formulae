
class Iioscope < Formula
  desc "IIO Oscilloscope NEW"
  homepage "https://github.com/analogdevicesinc/iio-oscilloscope/wiki"
  head "https://github.com/analogdevicesinc/iio-oscilloscope.git"

  # lib-2.0 gtk+-2.0 gthread-2.0 gtkdatabox fftw3 libiio libxml-2.0 libcurl jansson
  depends_on "cmake" => :build
  depends_on "gtk+" => :build
  depends_on "glib" => :build
  depends_on "pixman" => :build
  depends_on "cairo" => :build
  depends_on "pango" => :build
  depends_on "fribidi" => :build
  depends_on "atk" => :build
  depends_on "gdk-pixbuf" => :build
  depends_on "gtkdatabox" => :build
  depends_on "fftw" => :build
  depends_on "curl" => :build
  depends_on "jansson" => :build
  depends_on "libxml2" => :build
  depends_on "pkg-config" => :build
  depends_on "libmatio" => :build
  depends_on "gettext" => :build
  # depends_on "libiio" => :build
  # depends_on "libad9361-iio" => :build

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
