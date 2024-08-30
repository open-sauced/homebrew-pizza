class Pizza < Formula
  desc "The OpenSauced command-line tool"
  homepage "https://github.com/open-sauced/pizza-cli"
  version "v1.2.1"
  url "https://github.com/open-sauced/pizza-cli/archive/v1.2.1.tar.gz"
  sha256 "9c06c89b44b03adb3f8a9df19bf7bc2984dfe994b533fe5a492dedf6854c1775"
  license "MIT"

  head "https://github.com/open-sauced/pizza.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    with_env(
      "GO_LDFLAGS" => "-s -w -X 'github.com/open-sauced/pizza-cli/pkg/utils.writeOnlyPublicPosthogKey=phc_50r35wnPCQAV66xWzLDHPehBx3Sz0AaN5XG6kEOP9MJ' -X 'github.com/open-sauced/pizza-cli/pkg/utils.Version=v1.2.0' -X 'github.com/open-sauced/pizza-cli/pkg/utils.Sha=68fdede6057d147638e07c6fff0dcfb1fc7fbc5c' -X 'github.com/open-sauced/pizza-cli/pkg/utils.Datetime=2024-08-30-14:59:54'",
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
