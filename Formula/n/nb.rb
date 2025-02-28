class Nb < Formula
  desc "Command-line and local web note-taking, bookmarking, and archiving"
  homepage "https://xwmx.github.io/nb"
  url "https://github.com/xwmx/nb/archive/refs/tags/7.10.3.tar.gz"
  sha256 "fd4e049b6727368c762ed42a9690d2af6affe06ed8a03a084ee3548feef0d10f"
  license "AGPL-3.0-or-later"
  head "https://github.com/xwmx/nb.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1c45c91818c54c50f3fb074cc02e81c392a038db9f98c3f98e41efc2ac4b3b27"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1c45c91818c54c50f3fb074cc02e81c392a038db9f98c3f98e41efc2ac4b3b27"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1c45c91818c54c50f3fb074cc02e81c392a038db9f98c3f98e41efc2ac4b3b27"
    sha256 cellar: :any_skip_relocation, sonoma:         "0da1a0a17768e879a1d56e4ebaebc5733d689daf9904d2956edb235062a145a7"
    sha256 cellar: :any_skip_relocation, ventura:        "0da1a0a17768e879a1d56e4ebaebc5733d689daf9904d2956edb235062a145a7"
    sha256 cellar: :any_skip_relocation, monterey:       "0da1a0a17768e879a1d56e4ebaebc5733d689daf9904d2956edb235062a145a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1c45c91818c54c50f3fb074cc02e81c392a038db9f98c3f98e41efc2ac4b3b27"
  end

  depends_on "bat"
  depends_on "nmap"
  depends_on "pandoc"
  depends_on "ripgrep"
  depends_on "tig"
  depends_on "w3m"

  uses_from_macos "bash"

  def install
    bin.install "nb", "bin/bookmark"

    bash_completion.install "etc/nb-completion.bash" => "nb.bash"
    zsh_completion.install "etc/nb-completion.zsh" => "_nb"
    fish_completion.install "etc/nb-completion.fish" => "nb.fish"
  end

  test do
    # EDITOR must be set to a non-empty value for ubuntu-latest to pass tests!
    ENV["EDITOR"] = "placeholder"

    assert_match version.to_s, shell_output("#{bin}/nb version")

    system "yes | #{bin}/nb notebooks init"
    system bin/"nb", "add", "test", "note"
    assert_match "test note", shell_output("#{bin}/nb ls")
    assert_match "test note", shell_output("#{bin}/nb show 1")
    assert_match "1", shell_output("#{bin}/nb search test")
  end
end
