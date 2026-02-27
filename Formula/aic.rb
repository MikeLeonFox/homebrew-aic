class Aic < Formula
  desc "Manage multiple AI providers (Claude API, LiteLLM, Claude.ai) for Claude Code"
  homepage "https://github.com/MikeLeonFox/aic"
  url "https://github.com/MikeLeonFox/aic/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "30b6d1c47caacb58369dac874aa0435adc58748590b9697c19cde91879528bb5"
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
    assert_match "1.0.5", shell_output("#{bin}/aic --version")
  end
end
