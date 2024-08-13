class Saucectl < Formula
  desc "The saucectl command-line interface"
  homepage "https://github.com/open-sauced/saucectl"
  version "v1.1.0"
  url "https://github.com/open-sauced/saucectl/archive/v1.1.0.tar.gz"
  sha256 "3f473ecfc9cdbdfe5d7882549335f5f579acd164050bfeeeffe46ef365260977"
  license "MIT"

  head "https://github.com/open-sauced/saucectl.git", branch: "beta"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    with_env(
      "GO_LDFLAGS" => "-s -w -X 'github.com/open-sauced/saucectl/pkg/utils.Version=v1.1.0' -X 'github.com/open-sauced/saucectl/pkg/utils.Sha=7689fb054c20b2ace3e6d27092d6866507062c6c'",
    ) do
      system "go", "build"
    end
    bin.install "build/saucectl"
    generate_completions_from_executable(bin/"saucectl", "completion")
  end

  test do
    assert_match "A command line utility for deriving insights and metrics from git repos", shell_output("#{bin}/saucectl")
  end
end
