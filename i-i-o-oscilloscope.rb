
class IIOOscilloscope < Formula

  desc "IIO Oscilloscope"
  homepage "https://github.com/analogdevicesinc/iio-oscilloscope/wiki"
  head "https://github.com/analogdevicesinc/iio-oscilloscope.git"

  depends_on "cmake" => :build
  depends_on "gtk+" => :build
  depends_on "glib" => :build
  depends_on "cairo" => :build
  depends_on "pixman" => :build
  depends_on "fontconfig" => :build
  depends_on "freetype" => :build
  depends_on "libpng" => :build
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
  depends_on "harfbuzz" => :build
  depends_on "graphite2" => :build
  depends_on "libffi" => :build

  def install
    ENV.deparallelize
    system "cmake ./CMakeLists.txt -DCMAKE_INSTALL_PREFIX='#{prefix}'"
    system "make", "install"
  end

  test do
    system "false"
  end

end
