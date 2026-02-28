class Aic < Formula
  desc "Manage multiple AI providers (Claude API, LiteLLM, Claude.ai) for Claude Code"
  homepage "https://github.com/MikeLeonFox/aic"
  url "https://github.com/MikeLeonFox/aic/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "3b64dec27b9ab067f9419ac2fc7c29f93a4f3e3a165dacfc65bdff17b8798658"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install"
    system "npm", "run", "build"
    chmod 0755, "dist/index.js"
    libexec.install Dir["*"]
    (bin/"aic").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/index.js" "$@"
    SH
  end

  test do
    assert_match "1.1.0", shell_output("#{bin}/aic --version")
  end
end
