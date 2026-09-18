class Tokenfetch < Formula
  desc "Tokenfetch gives summary of Claude Code token usage and estimated API cost."
  homepage "https://github.com/fffelix-huang/tokenfetch"
  url "https://github.com/fffelix-huang/tokenfetch/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "9b24a7bd1067fcaca1134efae1fd97d7208211d4056f30a0bbbe7314e942e383"
  license "MIT"
  head "https://github.com/fffelix-huang/tokenfetch.git", branch: "master"

  depends_on "go" => :build

  deny_network_access!

  def fetch
    system "go", "mod", "download"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.revision=#{tap.user}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/tokenfetch"
  end

  test do
    assert_match "#{version} (#{tap.user})", shell_output("#{bin}/tokenfetch --version")
  end
end
