class Punch < Formula
  desc "Chess engine written in C++"
  homepage "https://github.com/fffelix-huang/Punch"
  url "https://github.com/fffelix-huang/Punch/archive/refs/tags/v1.0.tar.gz"
  sha256 "7bfaa3a0f763b3b6cc14bd1325e71947ce4d6990c98c37887ce31b484221951e"
  license "MIT"

  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    system "make", "all"
    bin.install "punch"
  end

  test do
    system bin/"punch", "bench"
  end
end
