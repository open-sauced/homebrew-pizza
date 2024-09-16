class Pizza < Formula
  desc "The OpenSauced command-line tool"
  homepage "https://github.com/open-sauced/pizza-cli"
  version "v2.1.0"
  url "https://github.com/open-sauced/pizza-cli/archive/v2.1.0.tar.gz"
  sha256 "2b353e9f5be42970e28fc0262dff7fe3adfdbb25aedfeb6758b21e6397ecc813"
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
      -X 'github.com/open-sauced/pizza-cli/pkg/utils.Sha=a659d86cd3a88d1856f4f1bd345e2b4d92fa4dd5'
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
