# security-trust-settings-tools

OS X Keychain Trust Settings Tools.

## Usage

### Blacklist Certificates

``` sh
security-trust-settings-blacklist [fingerprint ...] TrustSettings.plist
```

Generate blacklist for any certificate based on SHA1 fingerprint.


#### Example

``` sh
security-trust-settings-blacklist B94294BF91EA8FB64BE61097C7FB001359B676CB TrustSettings.plist
```

---

### Merge Trust Settings

``` sh
security-trust-settings-merge [plist ...] TrustSettings.plist
```

Merge multiple trust settings plists.

#### Example

``` sh
security-trust-settings-merge TrustSettings1.plist TrustSettings2.plist NewTrustSettings.plist
```

---



### Export System TrustSettings.plist

``` sh
security trust-settings-export -d ExportedTrustSettings.plist
```

### Import System TrustSettings.plist

``` sh
sudo security trust-settings-import -d NewTrustSettings.plist
```



## License

See [LICENSE](LICENSE).
