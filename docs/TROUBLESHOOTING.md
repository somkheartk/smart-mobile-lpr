# แก้ปัญหาที่พบบ่อย (Troubleshooting)

## 🔧 ปัญหาการติดตั้ง Flutter

### 1. Flutter Command Not Found

**อาการ:** เมื่อรัน `flutter` ใน terminal แสดง "command not found"

**วิธีแก้:**
```bash
# เพิ่ม Flutter ลงใน PATH
export PATH="$PATH:[PATH_TO_FLUTTER_DIR]/flutter/bin"

# หรือเพิ่มใน ~/.bashrc หรือ ~/.zshrc
echo 'export PATH="$PATH:/path/to/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
```

### 2. Flutter Doctor แสดง Errors

**วิธีแก้:** รัน `flutter doctor -v` เพื่อดูรายละเอียด และแก้ไขตามคำแนะนำ

## 📱 ปัญหา Android

### 1. Gradle Build Failed

**วิธีแก้:**
```bash
# ลบ build cache
cd android
./gradlew clean
cd ..

# ลบและติดตั้ง dependencies ใหม่
flutter clean
flutter pub get

# Build อีกครั้ง
flutter build apk
```

### 2. Camera Permission Issues

**อาการ:** แอปไม่สามารถเข้าถึงกล้องได้

**วิธีแก้:** เพิ่ม permissions ใน `android/app/src/main/AndroidManifest.xml`
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" android:required="false" />
```

### 3. Android Emulator ช้า

**วิธีแก้:**
- เปิด Hardware Acceleration:
  - **Intel:** ติดตั้ง HAXM
  - **AMD:** เปิดใช้งาน Hyper-V หรือใช้ Android x86 images
- หรือใช้อุปกรณ์จริง:
  ```bash
  flutter run -d <device-id>
  ```

### 4. MultiDex Error

**อาการ:** Cannot fit requested classes in a single dex file

**วิธีแก้:** แก้ไข `android/app/build.gradle`
```gradle
android {
    defaultConfig {
        multiDexEnabled true
    }
}

dependencies {
    implementation 'androidx.multidex:multidex:2.0.1'
}
```

## 🍎 ปัญหา iOS

### 1. Pod Install Failed

**วิธีแก้:**
```bash
cd ios

# อัปเดต CocoaPods
pod repo update

# ติดตั้งใหม่
pod install

# ถ้ายังไม่ได้ ลบและติดตั้งใหม่
pod deintegrate
pod install

cd ..
```

### 2. Code Signing Error

**วิธีแก้:**
1. เปิด `ios/Runner.xcworkspace` ใน Xcode
2. เลือก project "Runner"
3. ไปที่ "Signing & Capabilities"
4. เลือก Team และกำหนด Bundle Identifier

### 3. iOS Simulator Issues

**วิธีแก้:**
```bash
# รีเซ็ต simulator
xcrun simctl erase all

# เปิด simulator เฉพาะ
xcrun simctl boot "iPhone 15 Pro"

# รายชื่อ simulators ทั้งหมด
xcrun simctl list devices
```

## 🌐 ปัญหา Web

### 1. CORS Error

**อาการ:** Cannot load resources due to CORS policy

**วิธีแก้:**
- Development: รัน Chrome โดยปิด CORS checking
  ```bash
  flutter run -d chrome --web-browser-flag "--disable-web-security"
  ```
- Production: ตั้งค่า CORS headers ที่ backend

### 2. Font ไม่แสดงใน Web

**วิธีแก้:** ตรวจสอบ `pubspec.yaml` ว่ามีการกำหนด fonts ถูกต้อง:
```yaml
flutter:
  fonts:
    - family: Kanit
      fonts:
        - asset: assets/fonts/Kanit-Regular.ttf
```

## 🪟 ปัญหา Windows Desktop

### 1. Build Error - Missing Visual Studio

**วิธีแก้:** ติดตั้ง Visual Studio 2022 พร้อม "Desktop development with C++"

### 2. dll Missing

**วิธีแก้:** แจกจ่ายทั้งโฟลเดอร์ `build/windows/runner/Release/`

## 🐧 ปัญหา Linux Desktop

### 1. Missing Dependencies

**วิธีแก้:**
```bash
# Ubuntu/Debian
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev

# Fedora
sudo dnf install clang cmake ninja-build gtk3-devel
```

## 🔥 ปัญหาทั่วไป

### 1. Environment Variables ไม่โหลด

**อาการ:** `.env` file ไม่ถูกอ่าน

**วิธีแก้:**
```bash
# ตรวจสอบว่าไฟล์มีอยู่
ls -la .env

# คัดลอกจาก example
cp .env.example .env

# ตรวจสอบ pubspec.yaml
# ต้องมี:
flutter:
  assets:
    - .env
```

### 2. Hot Reload ไม่ทำงาน

**วิธีแก้:**
- กด `R` (Hot Restart) แทน `r` (Hot Reload)
- หรือหยุดและรันใหม่:
  ```bash
  flutter run
  ```

### 3. Fonts ไม่แสดงผล

**วิธีแก้:**
```bash
# ล้าง cache และ rebuild
flutter clean
flutter pub get
flutter run
```

### 4. Out of Memory During Build

**วิธีแก้:** แก้ไข `android/gradle.properties`
```properties
org.gradle.jvmargs=-Xmx4096m -XX:MaxPermSize=512m -XX:+HeapDumpOnOutOfMemoryError
```

### 5. Package Version Conflicts

**อาการ:** Could not resolve dependencies

**วิธีแก้:**
```bash
# อัปเดต dependencies
flutter pub upgrade

# หรือแก้ไขเฉพาะ package ใน pubspec.yaml
# เปลี่ยนจาก ^1.0.0 เป็น 1.0.0

# แล้วรัน
flutter pub get
```

### 6. Null Safety Errors

**อาการ:** Null check operator used on a null value

**วิธีแก้:**
```dart
// ใช้ null-aware operators
String? nullable;
print(nullable?.length);  // ไม่ error ถ้า null
print(nullable ?? 'default');  // ใช้ค่า default ถ้า null

// หรือ null check
if (nullable != null) {
  print(nullable.length);
}
```

### 7. Build Takes Too Long

**วิธีแก้:**
```bash
# ปิด unnecessary ไฟล์เปิด
# ลด plugins ที่ไม่จำเป็น
# เพิ่ม RAM ให้ Gradle (ดูข้อ 4)

# ใช้ --debug แทน --release ระหว่างพัฒนา
flutter run --debug
```

### 8. Assets Not Found

**อาการ:** Unable to load asset

**วิธีแก้:**
1. ตรวจสอบ path ใน code:
   ```dart
   Image.asset('assets/images/logo.png')  // ต้องตรงกับโครงสร้างไฟล์
   ```

2. ตรวจสอบ `pubspec.yaml`:
   ```yaml
   flutter:
     assets:
       - assets/images/
       - assets/fonts/
   ```

3. รัน:
   ```bash
   flutter clean
   flutter pub get
   ```

## 📊 ปัญหา Performance

### 1. แอปช้า/กระตุก

**วิธีแก้:**
- ใช้ `const` constructors
- ใช้ `ListView.builder` แทน `ListView`
- หลีกเลี่ยงการคำนวณหนักใน build method
- ใช้ Flutter DevTools เพื่อ profile:
  ```bash
  flutter run --profile
  ```

### 2. Memory Leaks

**วิธีแก้:**
- Dispose controllers ใน `dispose()` method:
  ```dart
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  ```
- ยกเลิก listeners และ streams

## 🆘 ขอความช่วยเหลือเพิ่มเติม

ถ้าปัญหายังไม่หาย:

1. **ค้นหาใน Documentation:**
   - [Flutter Docs](https://docs.flutter.dev)
   - [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

2. **ตรวจสอบ Logs:**
   ```bash
   flutter run -v  # Verbose mode
   ```

3. **เปิด Issue:**
   - [GitHub Issues](https://github.com/somkheartk/smart-mobile-lpr/issues)

4. **Community:**
   - [Flutter Discord](https://discord.gg/flutter)
   - [r/FlutterDev](https://www.reddit.com/r/FlutterDev/)

## 📝 เทมเพลตรายงานบั๊ก

```markdown
**อธิบายปัญหา:**
[อธิบายปัญหาที่เจอ]

**ขั้นตอนการทำซ้ำ:**
1. ...
2. ...
3. ...

**ผลลัพธ์ที่คาดหวัง:**
[อธิบายสิ่งที่คาดว่าจะเกิด]

**ผลลัพธ์จริง:**
[อธิบายสิ่งที่เกิดขึ้นจริง]

**Environment:**
- Flutter version: `flutter --version`
- Platform: [Android/iOS/Web/Windows/Linux/macOS]
- Device: [รุ่นอุปกรณ์หรือ emulator]

**Logs:**
```
[ใส่ error logs หรือ stack trace]
```

**Screenshots:**
[ถ้ามี]
```
