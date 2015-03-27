class SecurityTrustSettingsTools < Formula
  homepage "https://github.com/ntkme/security-trust-settings-tools"
  url "https://github.com/ntkme/security-trust-settings-tools/archive/v1.0.0.tar.gz"
  sha256 "db9ebfb813530c6c2bc990d74fa53bb79746dad8fe091c29bb1bd6ae975e6aea"
  head "https://github.com/ntkme/security-trust-settings-tools.git"

  depends_on :xcode => :build

  def install
    xcodebuild "install", "-alltargets", "SYMROOT=build", "DSTROOT=#{prefix}", "INSTALL_PATH=/bin"
  end

  test do
    system "security-trust-settings-blacklist"
  end
end
