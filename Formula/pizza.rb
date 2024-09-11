class Pizza < Formula
  desc "The OpenSauced command-line tool"
  homepage "https://github.com/open-sauced/pizza-cli"
  version "v1.4.0"
  url "https://github.com/open-sauced/pizza-cli/archive/v1.4.0.tar.gz"
  sha256 "61fa3b3d840cbec4837d8ad438663a086fa6ce04352aaf89d50bd0449c7dac5d"
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
      -X 'github.com/open-sauced/pizza-cli/pkg/utils.Sha=ae7a2b45f0c90e2bb4bb7f1727f90fd69d1b1d77'
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
