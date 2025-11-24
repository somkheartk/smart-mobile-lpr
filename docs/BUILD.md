# คู่มือการ Build และ Deploy

คู่มือนี้จะอธิบายวิธี build แอปพลิเคชันสำหรับแต่ละแพลตฟอร์ม

## 📱 Android

### Debug Build
```bash
flutter build apk --debug
# Output: build/app/outputs/flutter-apk/app-debug.apk
```

### Release Build
```bash
# Build release APK
flutter build apk --release

# Build split APKs (ขนาดเล็กกว่า)
flutter build apk --split-per-abi --release

# Output: build/app/outputs/flutter-apk/
```

### App Bundle (Google Play Store)
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### การ Sign APK

1. สร้าง keystore:
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. สร้างไฟล์ `android/key.properties`:
```properties
storePassword=<รหัสผ่าน>
keyPassword=<รหัสผ่าน key>
keyAlias=upload
storeFile=<path to keystore>
```

3. แก้ไข `android/app/build.gradle` เพื่อใช้ keystore

## 🍎 iOS

### Debug Build
```bash
flutter build ios --debug
```

### Release Build
```bash
flutter build ios --release
```

### การ Deploy ไป App Store

1. เปิด `ios/Runner.xcworkspace` ใน Xcode
2. เลือก Product > Archive
3. หลังจาก Archive เสร็จ ให้เลือก Validate แล้ว Distribute
4. อัปโหลดไป App Store Connect

### ข้อกำหนด
- macOS
- Xcode 12.0 หรือสูงกว่า
- Apple Developer account
- Certificates และ Provisioning Profiles

## 🌐 Web

### Build
```bash
# Build for web
flutter build web --release

# Build with custom base href
flutter build web --base-href "/app/" --release

# Output: build/web/
```

### Deploy

#### Firebase Hosting
```bash
firebase init hosting
firebase deploy
```

#### GitHub Pages
```bash
flutter build web --base-href "/repository-name/"
# อัปโหลด contents ของ build/web ไป gh-pages branch
```

#### Netlify
- เชื่อมต่อ repository กับ Netlify
- ตั้งค่า build command: `flutter build web`
- ตั้งค่า publish directory: `build/web`

## 🪟 Windows Desktop

### Build
```bash
flutter build windows --release
# Output: build/windows/runner/Release/
```

### การ Distribute
- แจกจ่ายทั้งโฟลเดอร์ Release
- หรือสร้าง installer ด้วย tools เช่น Inno Setup, NSIS

## 🐧 Linux Desktop

### Build
```bash
flutter build linux --release
# Output: build/linux/x64/release/bundle/
```

### ข้อกำหนด
- Linux (Ubuntu 18.04 หรือสูงกว่า)
- Clang
- CMake
- GTK development libraries
- Ninja build system

## 🍎 macOS Desktop

### Build
```bash
flutter build macos --release
# Output: build/macos/Build/Products/Release/
```

### ข้อกำหนด
- macOS 10.14 หรือสูงกว่า
- Xcode

## Optimization Tips

### ลดขนาดแอป

```bash
# ใช้ split APKs สำหรับ Android
flutter build apk --split-per-abi --release

# Enable tree-shaking (เปิดอัตโนมัติใน release mode)
flutter build apk --release

# ลบ resources ที่ไม่ใช้
flutter clean
```

### Code Obfuscation

```bash
# Build with obfuscation (ทำให้ reverse engineer ยากขึ้น)
flutter build apk --obfuscate --split-debug-info=/<path>/symbols

# สำหรับ iOS
flutter build ios --obfuscate --split-debug-info=/<path>/symbols
```

## CI/CD

### GitHub Actions Example

```yaml
name: Build and Deploy

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.9.2'
    
    - run: flutter pub get
    - run: flutter test
    - run: flutter build web --release
    
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./build/web
```

## Troubleshooting

### Build Failed - Gradle Issues (Android)
```bash
cd android
./gradlew clean
cd ..
flutter pub get
flutter build apk
```

### Pod Install Failed (iOS)
```bash
cd ios
pod repo update
pod install
cd ..
```

### Out of Memory
```bash
# แก้ไข android/gradle.properties
org.gradle.jvmargs=-Xmx4096m
```

## Resources

- [Flutter Build & Release Documentation](https://docs.flutter.dev/deployment)
- [Android App Bundle](https://developer.android.com/guide/app-bundle)
- [iOS App Distribution](https://developer.apple.com/documentation/xcode/distributing-your-app-for-beta-testing-and-releases)
