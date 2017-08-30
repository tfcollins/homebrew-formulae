class Libad9361Iio < Formula
  desc ""
  homepage ""
  head "https://github.com/analogdevicesinc/libad9361-iio.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build


  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cmake ./CMakeLists.txt -DCMAKE_INSTALL_PREFIX='#{prefix}'"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    system "false"
  end
end
