class Pizza < Formula
  desc "The OpenSauced command-line tool"
  homepage "https://github.com/open-sauced/pizza-cli"
  url "https://github.com/open-sauced/pizza-cli/archive/v1.0.1.tar.gz"
  sha256 "bb0e8f4c4c2a63c535e28515b1dfc27df8aceb4f3b43bf613362d4e0c156384b"
  license "MIT"

  head "https://github.com/open-sauced/pizza.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    with_env(
      "GO_LDFLAGS" => "-s -w",
    ) do
      system "make", "build"
    end
    bin.install "build/pizza"
    generate_completions_from_executable(bin/"pizza", "completion")
  end

  test do
    assert_match "A command line utility for insights, metrics, and all things OpenSauced", shell_output("#{bin}/pizza")
  end
end
