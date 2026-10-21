class Landmines < Formula
  desc "Known open bugs in your exact dependency versions, where your coding agent reads them"
  homepage "https://github.com/devanshranjan10/landmines"
  url "https://registry.npmjs.org/landmines/-/landmines-0.2.0.tgz"
  sha256 "e9b581bce8c33a80084835c83c476f49fdd97fc266a3e5263991037f2edeefcd"
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
