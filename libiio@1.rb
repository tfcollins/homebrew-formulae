class LibiioAT1 < Formula
  desc "Library for interfacing with local and remote Linux IIO devices"
  homepage "https://analogdevicesinc.github.io/libiio/"
  url "https://github.com/analogdevicesinc/libiio/archive/v1.0.0.tar.gz"
  sha256 "b4289bf9971f4a193c8c5f7fb40fbd4bd3f33654936b960b9539c7f2b484e44a"
  license "LGPL-2.1"
  head "https://github.com/analogdevicesinc/libiio.git", branch: "main"

  depends_on "cmake" => :build

  depends_on "libserialport"
  depends_on "libusb"

  uses_from_macos "libxml2"

  keg_only :versioned_formula

  def install
    mkdir "build" do
      cmake_args = [
        "-DOSX_INSTALL_FRAMEWORKSDIR=Frameworks",
        "-DOSX_PACKAGE=OFF",
      ]
      system "cmake", "..", *cmake_args, *std_cmake_args
      system "make"
      system "make", "install"
    end

    Dir.glob("#{frameworks}/iio.framework/Tools/*").each do |exec|
      bin.install_symlink exec if File.executable?(exec)
    end
    Dir.glob("#{prefix}/Library/Frameworks/iio.framework/Tools/*").each do |exec|
      bin.install_symlink exec if File.executable?(exec)
    end
  end

  test do
    system "#{bin}/iio_info", "-V"
  end
end
