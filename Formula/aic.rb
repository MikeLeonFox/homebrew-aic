class Aic < Formula
  desc "Manage multiple AI providers (Claude API, LiteLLM, Claude.ai) for Claude Code"
  homepage "https://github.com/MikeLeonFox/aic"
  url "https://github.com/MikeLeonFox/aic/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "cb451db0fc419eb93890d75fb735aa7a530d3d2dc3f91b49717cbc712f6ac3ab"
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
    assert_match "1.0.4", shell_output("#{bin}/aic --version")
  end
end
