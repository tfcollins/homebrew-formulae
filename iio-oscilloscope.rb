class IioOscilloscope < Formula
  desc "GTK+ based oscilloscope application for interfacing with various IIO devices"
  homepage "https://wiki.analog.com/resources/tools-software/linux-software/iio_oscilloscope"
  url "https://github.com/analogdevicesinc/iio-oscilloscope/archive/v0.11-master.tar.gz"
  sha256 "df31ae208f806f8291c3d4fd53d57d2e54acff4ab65c5ae52c18730fc76c6e64"
  license "GPL-2.0"
  head "https://github.com/analogdevicesinc/iio-oscilloscope.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "atk"
  depends_on "cairo"
  depends_on "curl"
  depends_on "fftw"
  depends_on "gdk-pixbuf"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+"
  depends_on "gtkdatabox-prev1"
  depends_on "harfbuzz"
  depends_on "jansson"
  depends_on "libad9361-iio"
  depends_on "libglade"
  depends_on "libiio"
  depends_on "libmatio"
  depends_on "libserialport"
  depends_on "pango"

  uses_from_macos "libxml2"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    assert_match "osc: the IIO visualization and control tool",
      shell_output("#{bin}/osc --help", 255)
  end
end
