class Pizza < Formula
  desc "The OpenSauced command-line tool"
  homepage "https://github.com/open-sauced/pizza-cli"
  version "v2.3.0"
  url "https://github.com/open-sauced/pizza-cli/archive/v2.3.0.tar.gz"
  sha256 "4636b4b931a9e5f50f1adf995aeaffc8e34fb3ac003ac1da548b1987269f0309"
  license "MIT"
  head "https://github.com/open-sauced/pizza-cli.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X 'github.com/open-sauced/pizza-cli/pkg/utils.Version=#{version}'
      -X 'github.com/open-sauced/pizza-cli/pkg/utils.Sha=1d4c8f97af7cc02dfbc01ce5927de89bf7c6d3c4'
      -X 'github.com/open-sauced/pizza-cli/pkg/utils.Datetime=#{Time.now.utc.strftime("%Y-%m-%d-%H:%M:%S")}'
      -X 'github.com/open-sauced/pizza-cli/pkg/utils.writeOnlyPublicPosthogKey=phc_50r35wnPCQAV66xWzLDHPehBx3Sz0AaN5XG6kEOP9MJ'
    ].join(" ")

    system "go", "build", "-ldflags", ldflags, "-o", "build/pizza"
    bin.install "build/pizza"
    generate_completions_from_executable(bin/"pizza", "completion")
  end

  test do
    assert_match "A command line utility for insights, metrics, and generating CODEOWNERS documentation for your open source projects", shell_output("#{bin}/pizza")
  end
end
