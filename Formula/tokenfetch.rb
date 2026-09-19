class Tokenfetch < Formula
  desc "Tokenfetch gives summary of Claude Code token usage and estimated API cost."
  homepage "https://github.com/fffelix-huang/tokenfetch"
  url "https://github.com/fffelix-huang/tokenfetch/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "0ba249b2dd571cddf6c208141d25353e9dafeb5148a876417f20c22a07ec9a67"
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
