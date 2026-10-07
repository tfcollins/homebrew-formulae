class IioOscilloscope < Formula
  desc "GTK+ based oscilloscope application for interfacing with various IIO devices"
  homepage "https://wiki.analog.com/resources/tools-software/linux-software/iio_oscilloscope"
  url "https://github.com/analogdevicesinc/iio-oscilloscope/archive/v0.18.1.tar.gz"
  sha256 "557ad13448bea0c8655920ab73e3d935abad15f8dceed293393f7af3f8c6ec4a"
  license "GPL-2.0"
  head "https://github.com/analogdevicesinc/iio-oscilloscope.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "cairo"
  depends_on "curl"
  depends_on "fftw"
  depends_on "gdk-pixbuf"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "gtkdatabox"
  depends_on "harfbuzz"
  depends_on "jansson"
  depends_on "libad9361-iio"
  depends_on "libiio"
  depends_on "libmatio"
  depends_on "libserialport"
  depends_on "pango"

  uses_from_macos "libxml2"

  def install
    ENV.append_to_cflags "-D_DARWIN_C_SOURCE" if OS.mac?

    inreplace "osc.h",
              "#define fallthrough\t__attribute__((__fallthrough__))",
              "#ifdef __APPLE__\n#include <os/base.h>\n#endif\n#define fallthrough\t__attribute__((__fallthrough__))"

    mkdir "build" do
      system "cmake", "..",
             "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
             "-DCMAKE_INSTALL_RPATH=#{lib}",
             "-DCMAKE_MACOSX_RPATH=1",
             "-DCMAKE_C_FLAGS=-D_DARWIN_C_SOURCE",
             *std_cmake_args
      system "make", "install"
    end
  end

  test do
    assert_match "osc: the IIO visualization and control tool",
      shell_output("#{bin}/osc --help", 255)
  end
end
