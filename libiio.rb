class Libiio < Formula
  desc "Library for interfacing with local and remote Linux IIO devices"
  homepage "https://analogdevicesinc.github.io/libiio/"
  url "https://github.com/analogdevicesinc/libiio/archive/v0.26.tar.gz"
  sha256 "fb445fb860ef1248759f45d4273a4eff360534480ec87af64c6b8db3b99be7e5"
  license "LGPL-2.1"
  head "https://github.com/analogdevicesinc/libiio.git"

  depends_on "cmake" => :build

  depends_on "libserialport"
  depends_on "libusb"

  uses_from_macos "libxml2"

  def install
    mkdir "build" do
      cmake_args = [
        "-DOSX_INSTALL_FRAMEWORKSDIR=#{frameworks}",
        "-DOSX_PACKAGE=OFF",
        "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
      ]
      system "cmake", "..", *cmake_args, *std_cmake_args
      system "make"
      system "make", "install"
    end

    Dir.glob("#{frameworks}/iio.framework/Tools/*").each do |exec|
      bin.install_symlink exec if File.executable?(exec)
    end

    Dir.glob("#{frameworks}/iio.framework/Headers/*").each do |header|
      include.install_symlink header
    end
    lib.install_symlink "#{frameworks}/iio.framework/iio" => "libiio.dylib" if File.exist?("#{frameworks}/iio.framework/iio")
  end

  test do
    system "#{bin}/iio_info", "--help"
  end
end
