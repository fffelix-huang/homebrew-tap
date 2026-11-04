class Tokenfetch < Formula
  desc "Tokenfetch gives summary of Claude Code token usage and estimated API cost."
  homepage "https://github.com/fffelix-huang/tokenfetch"
  url "https://github.com/fffelix-huang/tokenfetch/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "9dd6694b9ccfce728e546459a9ae5bf8f18c843a18153df1d440f03ab02f8a5e"
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
    generate_completions_from_executable(bin/"tokenfetch", shell_parameter_format: :flag)
  end

  test do
    assert_match "#{version} (#{tap.user})", shell_output("#{bin}/tokenfetch --version")
  end
end
