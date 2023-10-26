class Pizza < Formula
  desc "The OpenSauced command-line tool"
  homepage "https://github.com/open-sauced/pizza-cli"
  version "v1.1.0"
  url "https://github.com/open-sauced/pizza-cli/archive/v1.1.0.tar.gz"
  sha256 "fba87f90bd9ec04a4359f631724bf843e32120a171162af6991519ff7f391fb9"
  license "MIT"

  head "https://github.com/open-sauced/pizza.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    with_env(
      "GO_LDFLAGS" => "-s -w -X 'github.com/open-sauced/pizza-cli/pkg/utils.writeOnlyPublicPosthogKey=phc_50r35wnPCQAV66xWzLDHPehBx3Sz0AaN5XG6kEOP9MJ' -X 'github.com/open-sauced/pizza-cli/pkg/utils.Version=v1.1.0' -X 'github.com/open-sauced/pizza-cli/pkg/utils.Sha=ac37308459630a182218d5f0796b1c81a6f36e3d'",
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
