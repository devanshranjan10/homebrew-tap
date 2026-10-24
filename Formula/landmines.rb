class Landmines < Formula
  desc "Known open bugs in your pinned dependency versions, for coding agents"
  homepage "https://github.com/devanshranjan10/landmines"
  url "https://registry.npmjs.org/landmines/-/landmines-0.2.2.tgz"
  sha256 "f4cee5e118dc3d1e4599d0ed17f80620c2e95c60b8bad9187f87dc8af1adb5e4"
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
