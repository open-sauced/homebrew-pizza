class Pizza < Formula
  desc "The OpenSauced command-line tool"
  homepage "https://github.com/open-sauced/pizza-cli"
  version "v1.2.1"
  url "https://github.com/open-sauced/pizza-cli/archive/v1.3.0.tar.gz"
  sha256 "5da48a17c0744fc037dfbe2d1ab1414ef6a3cfd9859237c2f2c8d3454c85dbf4"
  license "MIT"

  head "https://github.com/open-sauced/pizza.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    with_env(
      "GO_LDFLAGS" => "-s -w -X 'github.com/open-sauced/pizza-cli/pkg/utils.writeOnlyPublicPosthogKey=phc_50r35wnPCQAV66xWzLDHPehBx3Sz0AaN5XG6kEOP9MJ' -X 'github.com/open-sauced/pizza-cli/pkg/utils.Version=v1.3.0' -X 'github.com/open-sauced/pizza-cli/pkg/utils.Sha=b1f1b9555957daf6247bccaf08ce476a61d03206' -X 'github.com/open-sauced/pizza-cli/pkg/utils.Datetime=2024-09-06-09:40:02'",
    ) do
      system "go", "build", "-o=build/pizza"
    end
    bin.install "build/pizza"
    generate_completions_from_executable(bin/"pizza", "completion")
  end

  test do
    assert_match "A command line utility for insights, metrics, and all things OpenSauced", shell_output("#{bin}/pizza")
  end
end
