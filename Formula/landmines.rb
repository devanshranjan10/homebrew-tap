class Landmines < Formula
  desc "Known open bugs in your pinned dependency versions, for coding agents"
  homepage "https://github.com/devanshranjan10/landmines"
  url "https://registry.npmjs.org/landmines/-/landmines-0.2.1.tgz"
  sha256 "7e8f7a32b6c8615d5e9be51a0fdffc7c3c62d95ac4d62ba80ccef1f4894a7281"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/landmine --version")
    (testpath/"package-lock.json").write <<~JSON
      {"name":"t","version":"1.0.0","lockfileVersion":3,"packages":{"":{"dependencies":{"zod":"3.23.8"}},"node_modules/zod":{"version":"3.23.8"}}}
    JSON
    system bin/"landmine", "scan", "--offline", "-q"
  end
end
