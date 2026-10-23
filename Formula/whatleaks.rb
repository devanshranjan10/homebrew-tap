class Whatleaks < Formula
  desc "See what an app sends home, and what it still sends after you opt out"
  homepage "https://whatleaks.me"
  url "https://registry.npmjs.org/whatleaks/-/whatleaks-0.1.0.tgz"
  sha256 "fe79f5e2a0a6d2467745dd6f778e84815f39779f359eb017b0cc4099c7bdcfab"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # mockttp's optional TLS-fingerprint module ships prebuilds for every platform; keep this one's.
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.intel? ? "x64" : "arm64"
    prebuilds = libexec/"lib/node_modules/whatleaks/node_modules/tls-impersonate/prebuilds"
    prebuilds.children.each { |dir| rm_r(dir) if dir.basename.to_s != "#{os}-#{arch}" } if prebuilds.exist?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/whatleaks --version")
    assert_match "DO_NOT_TRACK", shell_output("#{bin}/whatleaks opt-outs")
    (testpath/"t.har").write <<~JSON
      {"log":{"version":"1.2","creator":{"name":"t","version":"1"},"entries":[{"startedDateTime":"2026-10-24T00:00:00.000Z","time":1,"request":{"method":"POST","url":"https://telemetry.nextjs.org/api/v1/record","httpVersion":"HTTP/1.1","headers":[],"queryString":[],"postData":{"mimeType":"application/json","text":"{\\"meta\\":{\\"cpuCount\\":8}}"},"headersSize":-1,"bodySize":22},"response":{"status":204,"statusText":"","httpVersion":"HTTP/1.1","headers":[],"content":{"size":0,"mimeType":""},"redirectURL":"","headersSize":-1,"bodySize":0},"cache":{},"timings":{"send":0,"wait":1,"receive":0}}]}}
    JSON
    assert_match "Next.js telemetry", shell_output("#{bin}/whatleaks report t.har")
  end
end
