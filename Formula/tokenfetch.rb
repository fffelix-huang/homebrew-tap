class Tokenfetch < Formula
  desc "Tokenfetch gives summary of Claude Code token usage and estimated API cost."
  homepage "https://github.com/fffelix-huang/tokenfetch"
  url "https://github.com/fffelix-huang/tokenfetch/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "edb7464ae49116cb7887d40b717b29d5b0be94ee64b7179f0d28a77dab2b048d"
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
