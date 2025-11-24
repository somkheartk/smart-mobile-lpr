# 🚗 Smart Mobile LPR (License Plate Recognition)

ระบบตรวจจับและติดตามป้ายทะเบียนรถอัจฉริยะ พัฒนาด้วย Flutter สำหรับการทำงานแบบ Cross-Platform

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows-blue)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)

---

## 📖 Table of Contents

- [Features](#-features)
- [Architecture](#️-architecture)
- [Technologies](#️-technologies)
- [Getting Started](#-getting-started)
- [API Documentation](#-api-documentation)
- [Development Guide](#-development-guide)
- [Testing](#-testing)
- [Build & Deployment](#-build--deployment)
- [Troubleshooting](#-troubleshooting)
- [Performance Tips](#-performance-tips)
- [Security](#-security)
- [FAQ](#-faq)
- [Contributing](#-contributing)
- [License](#-license)

---

## 📱 Screenshots

> **Note**: Screenshots will be added after the application is fully tested on various platforms. For now, you can run the application locally to see the UI in action.

| Login | Dashboard | Camera |
|:---:|:---:|:---:|
| ![Login](screenshots/login.png) | ![Dashboard](screenshots/dashboard.png) | ![Camera](screenshots/camera.png) |
| หน้าเข้าสู่ระบบ | แสดงสถิติรวม | สแกนป้ายทะเบียน |

| Vehicle List | Statistics | Settings |
|:---:|:---:|:---:|
| ![Vehicle List](screenshots/vehicle_list.png) | ![Statistics](screenshots/statistics.png) | ![Settings](screenshots/settings.png) |
| รายการรถทั้งหมด | สถิติโดยละเอียด | การตั้งค่า |

---

## ✨ Features

### 🔐 Authentication
- ✅ Login/Logout System
- ✅ Session Management
- ✅ User Profile

### 📊 Dashboard & Analytics
- ✅ Real-time Statistics
- ✅ Interactive Charts (Line, Bar, Pie)
- ✅ Today/Monthly Detection Count
- ✅ Operator Performance Tracking
- ✅ Violation Type Analysis

### 📷 Camera & Scanning
- ✅ Live Camera Preview
- ✅ Real-time Plate Detection (Mock)
- ✅ Vehicle Type Recognition
- ✅ Auto-save Detection Results

### 🚗 Vehicle Management
- ✅ Vehicle List with Search
- ✅ Filter by Status & Date
- ✅ Detailed Vehicle Information
- ✅ Violation Alerts
- ✅ Pull-to-refresh

### ⚙️ Settings
- ✅ Profile Management
- ✅ System Configuration
- ✅ Data Export
- ✅ App Information

## 🏗️ Architecture

### Clean Architecture Pattern
```
lib/
├── core/
│   ├── constants/      # Colors, Strings, Dimensions
│   ├── theme/          # App Theme Configuration
│   └── utils/          # Helpers & Utilities
├── models/             # Data Models
├── services/           # Business Logic Layer
├── widgets/            # Reusable Widgets
└── pages/              # UI Screens
```

### Key Design Patterns
- **Singleton Pattern** - Services
- **Repository Pattern** - Data Layer
- **State Management** - StatefulWidget with setState
- **Dependency Injection** - Service Locators

## 🛠️ Technologies

### Core
- **Flutter** 3.9.2 - UI Framework
- **Dart** 3.9.2 - Programming Language
- **Material Design 3** - Design System

### Packages
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  fl_chart: ^0.69.0          # Charts & Graphs
  intl: ^0.19.0              # Internationalization
  camera: ^0.11.0            # Camera Access
  path_provider: ^2.1.1      # File System
  path: ^1.9.0               # Path Manipulation
  image_picker: ^1.0.4       # Image Selection
  flutter_dotenv: ^5.1.0     # Environment Configuration
```

### Fonts
- **Kanit** - Thai Font (Regular, Medium, Bold)

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

#### Required
- **Flutter SDK** 3.9.2 or higher
  - Download from [flutter.dev](https://flutter.dev)
  - Verify: `flutter --version`
- **Dart SDK** 3.9.2 or higher (included with Flutter)
- **Git** for version control
  - Download from [git-scm.com](https://git-scm.com)

#### Platform-Specific Requirements

**For Android Development:**
- Android Studio or IntelliJ IDEA
- Android SDK (API 21 or higher)
- Android Emulator or physical device
- Java Development Kit (JDK) 11 or higher

**For iOS Development (macOS only):**
- Xcode 12.0 or higher
- CocoaPods (`sudo gem install cocoapods`)
- iOS Simulator or physical device
- Apple Developer account (for device testing)

**For Web Development:**
- Chrome, Edge, Safari, or Firefox browser
- No additional setup required

**For Windows Development:**
- Visual Studio 2022 (with C++ development tools)
- Windows 10 version 1809 or higher

**For Linux Development:**
- Clang
- CMake
- GTK development libraries
- Ninja build system

#### Verify Installation

Run Flutter doctor to check your setup:
```bash
flutter doctor -v
```

All required components should show checkmarks ✓

### Installation

#### 1. Clone Repository
```bash
git clone https://github.com/somkheartk/smart-mobile-lpr.git
cd smart-mobile-lpr
```

#### 2. Setup Environment Variables
```bash
# Copy environment template
cp .env.example .env

# Edit .env file with your configuration
# Linux/Mac
nano .env
# or
vim .env

# Windows
notepad .env
```

**Required Environment Variables:**
- `API_BASE_URL`: Your backend API URL
- `API_KEY`: Your API authentication key (if required)
- Configure other settings as needed (see `.env.example` for all options)

#### 3. Install Dependencies
```bash
# Fetch all Flutter packages
flutter pub get

# This may take a few minutes on first run
```

#### 4. Verify Assets
```bash
# Ensure fonts are in place
ls assets/fonts/
# Should show: Kanit-Regular.ttf, Kanit-Medium.ttf, Kanit-Bold.ttf
```

#### 5. Run Application
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Or simply run (Flutter will ask you to choose)
flutter run
```

**Platform-Specific Run Commands:**
```bash
# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios

# Web (Chrome)
flutter run -d chrome

# Web (Edge)  
flutter run -d edge

# Windows Desktop
flutter run -d windows

# macOS Desktop
flutter run -d macos

# Linux Desktop
flutter run -d linux
```

#### 6. Choose Target Platform

When you run `flutter run`, you'll see a list:
```
Connected devices:
[1]: sdk gphone64 x86 64 (mobile) • emulator-5554 • android-x64 • Android 13 (API 33)
[2]: Chrome (web) • chrome • web-javascript • Google Chrome 120.0.6099.109
[3]: Windows (desktop) • windows • windows-x64 • Microsoft Windows [Version 10.0.19045.3803]

Please choose one (or "q" to quit):
```

Enter the number of your target platform.

### Demo Credentials
```
Username: admin
Password: admin123

-- OR --

Username: operator1
Password: operator123
```

### Environment Configuration

The application uses `.env` file for configuration. Key settings include:

- **API Configuration**: Base URL, timeout, API keys
- **Camera Settings**: Quality, flash mode
- **Detection Settings**: Confidence threshold, max attempts
- **Feature Flags**: Enable/disable features
- **Third Party**: Firebase, analytics services

See `.env.example` for all available configuration options.

## 📁 Project Structure

```
mobile_lpr/
├── android/                    # Android native code
├── ios/                        # iOS native code
├── lib/
│   ├── core/
│   │   ├── config/
│   │   │   └── app_config.dart       # Environment configuration
│   │   ├── constants/
│   │   │   ├── app_colors.dart       # Color palette
│   │   │   ├── app_strings.dart      # Thai strings
│   │   │   └── app_dimensions.dart   # Spacing values
│   │   ├── theme/
│   │   │   └── app_theme.dart        # Theme config
│   │   └── utils/
│   │       ├── date_time_helper.dart # Date formatting
│   │       ├── number_formatter.dart # Number formatting
│   │       ├── validators.dart       # Input validation
│   │       └── ui_helpers.dart       # UI helpers
│   ├── models/
│   │   ├── vehicle.dart              # Vehicle model
│   │   ├── statistics.dart           # Statistics models
│   │   ├── operator.dart             # Operator model
│   │   ├── user.dart                 # User model
│   │   └── api_response.dart         # API wrapper
│   ├── services/
│   │   ├── auth_service.dart         # Authentication
│   │   ├── vehicle_service.dart      # Vehicle operations
│   │   ├── statistics_service.dart   # Statistics data
│   │   └── operator_service.dart     # Operator data
│   ├── widgets/
│   │   ├── stat_card.dart            # Statistics card
│   │   ├── vehicle_card.dart         # Vehicle card
│   │   └── section_header.dart       # Section title
│   ├── pages/
│   │   ├── login_page.dart           # Login screen
│   │   ├── main_navigator.dart       # Bottom navigation
│   │   ├── dashboard_page.dart       # Dashboard
│   │   ├── camera_page.dart          # Camera scanner
│   │   ├── statistics_page.dart      # Statistics
│   │   ├── vehicle_list_page.dart    # Vehicle list
│   │   └── settings_page.dart        # Settings
│   └── main.dart                     # Entry point
├── assets/
│   └── fonts/                        # Kanit fonts
├── test/                             # Unit tests
├── .env                              # Environment variables (git ignored)
├── .env.example                      # Environment template
├── pubspec.yaml                      # Dependencies
└── README.md                         # This file
```

## 🎨 Design System

### Colors
- **Primary Blue**: `#4A90E2`
- **Success Green**: `#4CAF50`
- **Warning Yellow**: `#FF9800`
- **Error Red**: `#F44336`
- **Background**: `#F5F7FA`

### Typography
- **Font Family**: Kanit
- **Sizes**: 12, 14, 16, 18, 20, 24, 28, 32
- **Weights**: Regular (400), Medium (500), Bold (700)

### Components
- **Border Radius**: 8, 12, 16, 20, 24
- **Spacing**: 4, 8, 12, 16, 20, 24, 32
- **Shadows**: Elevation 2, 4, 8, 16

## 🔄 State Management

Currently using **StatefulWidget with setState**. 

Future enhancements may include:
- Provider
- Riverpod
- Bloc Pattern

## 📊 Data Layer

### Mock Data
All services use **mock data** for development and demonstration.

### Future Enhancements
- REST API Integration
- Local Database (SQLite/Hive)
- Cloud Sync (Firebase)
- Real ML Model Integration

## 📚 API Documentation

### Services Layer

The application uses service classes to manage business logic and data operations:

#### AuthService
```dart
// Singleton instance
final authService = AuthService();

// Login
await authService.login(username, password);

// Check authentication status
bool isLoggedIn = authService.isAuthenticated;

// Get current user
User? currentUser = authService.currentUser;

// Logout
authService.logout();
```

#### VehicleService
```dart
final vehicleService = VehicleService();

// Get all vehicles
List<Vehicle> vehicles = vehicleService.getVehicles();

// Search vehicles
List<Vehicle> results = vehicleService.searchVehicles('กก 1234');

// Filter by status
List<Vehicle> filtered = vehicleService.filterByStatus(VehicleStatus.violation);

// Add new vehicle detection
vehicleService.addVehicle(newVehicle);
```

#### StatisticsService
```dart
final statsService = StatisticsService();

// Get today's statistics
Statistics todayStats = statsService.getTodayStatistics();

// Get monthly statistics
Statistics monthlyStats = statsService.getMonthlyStatistics();

// Get detection trends (for charts)
List<DetectionData> trends = statsService.getDetectionTrends();
```

### Models

#### Vehicle Model
```dart
class Vehicle {
  final String id;
  final String licensePlate;
  final VehicleType type;
  final DateTime detectedAt;
  final VehicleStatus status;
  final String? violationType;
  final String operator;
}

enum VehicleType { car, pickup, van, truck, motorcycle }
enum VehicleStatus { normal, violation }
```

#### User Model
```dart
class User {
  final String id;
  final String username;
  final String fullName;
  final String role;
  final String? profileImage;
}
```

## 👨‍💻 Development Guide

### Setting Up Development Environment

1. **Install Flutter SDK**
   ```bash
   # Download Flutter SDK from https://flutter.dev
   # Add to PATH
   export PATH="$PATH:`pwd`/flutter/bin"
   
   # Verify installation
   flutter doctor
   ```

2. **Install IDE Extensions**
   - **VS Code**: Flutter, Dart, Flutter Widget Snippets
   - **Android Studio**: Flutter Plugin, Dart Plugin

3. **Clone and Setup**
   ```bash
   git clone https://github.com/somkheartk/smart-mobile-lpr.git
   cd smart-mobile-lpr
   
   # Copy environment file
   cp .env.example .env
   
   # Install dependencies
   flutter pub get
   
   # Run code generation (if needed)
   flutter pub run build_runner build
   ```

### Code Style Guidelines

- **File Naming**: Use `snake_case` for file names (e.g., `vehicle_service.dart`)
- **Class Naming**: Use `PascalCase` for class names (e.g., `VehicleService`)
- **Variables**: Use `camelCase` for variables (e.g., `currentUser`)
- **Constants**: Use `lowerCamelCase` with `const` (e.g., `const primaryColor`)
- **Private Members**: Prefix with underscore (e.g., `_privateMethod`)

### Adding New Features

1. **Create Model** (if needed)
   ```dart
   // lib/models/my_model.dart
   class MyModel {
     final String id;
     final String name;
     
     MyModel({required this.id, required this.name});
   }
   ```

2. **Create Service**
   ```dart
   // lib/services/my_service.dart
   class MyService {
     static final MyService _instance = MyService._internal();
     factory MyService() => _instance;
     MyService._internal();
     
     // Your methods here
   }
   ```

3. **Create Widget**
   ```dart
   // lib/widgets/my_widget.dart
   class MyWidget extends StatelessWidget {
     const MyWidget({super.key});
     
     @override
     Widget build(BuildContext context) {
       return Container();
     }
   }
   ```

4. **Create Page**
   ```dart
   // lib/pages/my_page.dart
   class MyPage extends StatefulWidget {
     const MyPage({super.key});
     
     @override
     State<MyPage> createState() => _MyPageState();
   }
   
   class _MyPageState extends State<MyPage> {
     @override
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(title: const Text('My Page')),
         body: Container(),
       );
     }
   }
   ```

### Hot Reload & Hot Restart

- **Hot Reload**: Press `r` in terminal or `Ctrl+S` in IDE
  - Fast UI updates without losing state
  - Use for UI changes
  
- **Hot Restart**: Press `R` in terminal
  - Full app restart with state reset
  - Use for logic changes or state issues

### Debugging Tips

1. **Print Debugging**
   ```dart
   debugPrint('Debug message: $variable');
   ```

2. **Flutter DevTools**
   ```bash
   flutter pub global activate devtools
   flutter pub global run devtools
   ```

3. **Widget Inspector**
   - Press `p` in terminal to show performance overlay
   - Press `w` to toggle widget inspector

4. **Debug Console**
   - View logs in IDE debug console
   - Filter by log level

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/services/auth_service_test.dart

# Run with coverage
flutter test --coverage

# Generate coverage report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
```

### Test Structure

```dart
// test/services/auth_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_lpr/services/auth_service.dart';

void main() {
  group('AuthService', () {
    late AuthService authService;
    
    setUp(() {
      authService = AuthService();
    });
    
    test('should login with valid credentials', () async {
      final result = await authService.login('admin', 'admin123');
      expect(result, isTrue);
      expect(authService.isAuthenticated, isTrue);
    });
    
    test('should reject invalid credentials', () async {
      final result = await authService.login('wrong', 'wrong');
      expect(result, isFalse);
      expect(authService.isAuthenticated, isFalse);
    });
  });
}
```

### Widget Testing

```dart
// test/widgets/stat_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_lpr/widgets/stat_card.dart';

void main() {
  testWidgets('StatCard displays correct values', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StatCard(
            title: 'Total',
            value: '100',
            color: Colors.blue,
            icon: Icons.car_rental,
          ),
        ),
      ),
    );
    
    expect(find.text('Total'), findsOneWidget);
    expect(find.text('100'), findsOneWidget);
    expect(find.byIcon(Icons.car_rental), findsOneWidget);
  });
}
```

## 📦 Build & Deployment

### Android APK

#### Debug Build
```bash
flutter build apk --debug
# Output: build/app/outputs/flutter-apk/app-debug.apk
```

#### Release Build
```bash
# Build release APK
flutter build apk --release

# Build split APKs (smaller size)
flutter build apk --split-per-abi --release

# Output: build/app/outputs/flutter-apk/
```

#### App Bundle (Google Play)
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS IPA

```bash
# Ensure certificates and provisioning profiles are configured
flutter build ios --release

# Archive in Xcode for distribution
# Open ios/Runner.xcworkspace in Xcode
# Product > Archive
```

### Web

```bash
# Build for web
flutter build web --release

# Build with custom base href
flutter build web --base-href "/app/" --release

# Deploy to hosting
# Upload contents of build/web to your web server
```

### Windows Desktop

```bash
# Build Windows executable
flutter build windows --release

# Output: build/windows/runner/Release/
# Distribute the entire Release folder
```

### Linux Desktop

```bash
flutter build linux --release
# Output: build/linux/x64/release/bundle/
```

### macOS Desktop

```bash
flutter build macos --release
# Output: build/macos/Build/Products/Release/
```

## 🐛 Troubleshooting

### Common Issues and Solutions

#### 1. Flutter Command Not Found
```bash
# Add Flutter to PATH
export PATH="$PATH:[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin"

# Or add to ~/.bashrc or ~/.zshrc permanently
echo 'export PATH="$PATH:/path/to/flutter/bin"' >> ~/.bashrc
```

#### 2. Camera Permission Issues

**Android**: Add to `android/app/src/main/AndroidManifest.xml`
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" />
```

**iOS**: Add to `ios/Runner/Info.plist`
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to scan license plates</string>
```

#### 3. Environment Variables Not Loading

**Problem**: `.env` file not found or not loading
```bash
# Ensure .env file exists
cp .env.example .env

# Verify it's in project root
ls -la .env

# Check pubspec.yaml assets section includes .env
```

#### 4. Font Not Displaying Correctly

**Solution**: Clear Flutter cache and rebuild
```bash
flutter clean
flutter pub get
flutter run
```

#### 5. Build Failed - Gradle Issues (Android)

```bash
# Clean project
cd android
./gradlew clean
cd ..

# Update dependencies
flutter pub get

# Rebuild
flutter build apk
```

#### 6. Pod Install Failed (iOS)

```bash
# Navigate to iOS directory
cd ios

# Update CocoaPods
pod repo update
pod install

# If still failing, try
pod deintegrate
pod install

cd ..
```

#### 7. Out of Memory During Build

```bash
# Increase Java heap size (Android)
# Edit android/gradle.properties
org.gradle.jvmargs=-Xmx4096m -XX:MaxPermSize=512m -XX:+HeapDumpOnOutOfMemoryError

# Or run with more memory
flutter build apk --release --verbose
```

#### 8. Hot Reload Not Working

```bash
# Try hot restart instead (press R in terminal)
# Or stop and restart the app
flutter run
```

### Platform-Specific Issues

#### Android Emulator Slow

```bash
# Enable hardware acceleration
# Intel: Install HAXM
# AMD: Enable Hyper-V or use Android x86 images

# Use Flutter on physical device instead
flutter run -d <device-id>
```

#### iOS Simulator Issues

```bash
# Reset simulator
xcrun simctl erase all

# Boot specific simulator
xcrun simctl boot "iPhone 15 Pro"
```

## ⚡ Performance Tips

### 1. Use `const` Constructors
```dart
// Good
const Text('Hello')

// Bad
Text('Hello')
```

### 2. Avoid Rebuilding Widgets Unnecessarily
```dart
// Use const widgets when possible
const StatCard(title: 'Total', value: '100', ...)

// Split widgets into smaller components
// Use Keys for list items
```

### 3. Lazy Loading Lists
```dart
// Use ListView.builder instead of ListView
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ItemWidget(item: items[index]);
  },
)
```

### 4. Image Optimization
```dart
// Use cached network images
CachedNetworkImage(
  imageUrl: url,
  placeholder: (context, url) => CircularProgressIndicator(),
)

// Resize images appropriately
Image.asset('image.png', width: 100, height: 100, fit: BoxFit.cover)
```

### 5. Avoid Expensive Operations in Build
```dart
// Bad - calculation in build method
@override
Widget build(BuildContext context) {
  final expensiveValue = calculateExpensiveValue(); // Don't do this
  return Text(expensiveValue);
}

// Good - calculate in initState or use memoization
late String cachedValue;

@override
void initState() {
  super.initState();
  cachedValue = calculateExpensiveValue();
}
```

### 6. Profile Your App
```bash
# Run in profile mode
flutter run --profile

# Use DevTools for performance analysis
flutter pub global activate devtools
flutter pub global run devtools
```

### 7. Reduce App Size
```bash
# Use split APKs
flutter build apk --split-per-abi

# Enable tree-shaking (automatic in release)
flutter build apk --release

# Remove unused resources
flutter clean
```

## 🔒 Security

### Best Practices

#### 1. Environment Variables
- ✅ **Never commit `.env` file to repository**
- ✅ Use `.env.example` as template
- ✅ Store sensitive data in environment variables
- ❌ Don't hardcode API keys or secrets

#### 2. Authentication
```dart
// Store tokens securely
// Use flutter_secure_storage for sensitive data
final storage = FlutterSecureStorage();
await storage.write(key: 'auth_token', value: token);

// Don't store passwords in plain text
// Always use hashing on backend
```

#### 3. Input Validation
```dart
// Validate all user inputs
String? validatePlateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'กรุณากรอกหมายเลขทะเบียน';
  }
  if (!RegExp(r'^[ก-ฮ0-9]{1,3}\s?[ก-ฮ]{0,2}\s?\d{1,4}$').hasMatch(value)) {
    return 'รูปแบบทะเบียนไม่ถูกต้อง';
  }
  return null;
}
```

#### 4. Network Security
```dart
// Use HTTPS only
const apiBaseUrl = 'https://api.example.com'; // ✅
// Not: 'http://api.example.com' // ❌

// Implement certificate pinning for sensitive apps
// Use dio with certificate pinning
```

#### 5. Data Encryption
```dart
// Encrypt sensitive data before storage
// Use encryption libraries like encrypt package
final key = Key.fromUtf8('my32lengthsupersecretnooneknows');
final iv = IV.fromLength(16);
final encrypter = Encrypter(AES(key));

final encrypted = encrypter.encrypt(plainText, iv: iv);
final decrypted = encrypter.decrypt(encrypted, iv: iv);
```

#### 6. API Security
- Use authentication tokens (JWT)
- Implement rate limiting
- Validate all responses from server
- Handle errors gracefully without exposing system details

#### 7. Code Obfuscation
```bash
# Build with obfuscation
flutter build apk --obfuscate --split-debug-info=/path/to/symbols

# Protect intellectual property
# Makes reverse engineering harder
```

### Security Checklist

- [ ] Environment variables properly configured
- [ ] No hardcoded secrets in code
- [ ] Input validation implemented
- [ ] HTTPS used for all network calls
- [ ] Sensitive data encrypted
- [ ] Authentication tokens securely stored
- [ ] Code obfuscation enabled for release builds
- [ ] Permissions minimized (only request what's needed)
- [ ] Error messages don't leak sensitive information
- [ ] Dependencies regularly updated for security patches

## ❓ FAQ

### General Questions

**Q: Can I use this app for production?**  
A: Currently, this is a demo application with mock data. For production use, you need to:
- Integrate with a real backend API
- Implement real license plate recognition (ML model)
- Add proper authentication and authorization
- Set up database for persistent storage
- Implement proper error handling and logging

**Q: Which platforms are supported?**  
A: The app is built with Flutter and supports:
- ✅ Android (5.0+)
- ✅ iOS (12.0+)
- ✅ Web (Chrome, Safari, Edge, Firefox)
- ✅ Windows (10+)
- ✅ macOS (10.14+)
- ✅ Linux

**Q: Is this app free to use?**  
A: Yes, it's open source under MIT License. You can use, modify, and distribute it freely.

### Technical Questions

**Q: How do I add a new page?**  
A: Follow these steps:
1. Create page file in `lib/pages/`
2. Add to navigation in `main_navigator.dart`
3. Update routes if using named routes
4. Add necessary imports

**Q: Can I change the language to English?**  
A: Yes, edit `lib/core/constants/app_strings.dart` and replace Thai strings with English, or implement proper i18n using the `intl` package.

**Q: How do I integrate a real ML model?**  
A: Replace the mock detection in `camera_page.dart` with:
- TensorFlow Lite model integration
- Or call a backend API with ML inference
- Or use cloud services like Google ML Kit

**Q: Can I use a different state management solution?**  
A: Yes, you can migrate to:
- Provider (recommended for beginners)
- Riverpod (type-safe, modern)
- Bloc (for complex apps)
- GetX (all-in-one solution)

**Q: How do I add more vehicle types?**  
A: Edit `lib/models/vehicle.dart` and add to the `VehicleType` enum:
```dart
enum VehicleType {
  car,
  pickup,
  van,
  truck,
  motorcycle,
  bus,        // Add new types
  trailer,
}
```

**Q: How can I export data to Excel/PDF?**  
A: Add packages:
```yaml
dependencies:
  excel: ^4.0.0      # For Excel export
  pdf: ^3.10.0       # For PDF generation
  printing: ^5.11.0  # For printing PDFs
```

### Deployment Questions

**Q: How do I deploy to Google Play Store?**  
A:
1. Create app bundle: `flutter build appbundle --release`
2. Sign the bundle with your keystore
3. Upload to Google Play Console
4. Fill in store listing details
5. Submit for review

**Q: How do I deploy to Apple App Store?**  
A:
1. Configure signing in Xcode
2. Archive the app: Product > Archive
3. Validate and upload via Xcode
4. Submit for review in App Store Connect

**Q: Can I host the web version on GitHub Pages?**  
A: Yes:
```bash
# Build for web
flutter build web --base-href "/smart-mobile-lpr/"

# Push to gh-pages branch
# Or use GitHub Actions for automatic deployment
```

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

### Ways to Contribute

- 🐛 Report bugs and issues
- 💡 Suggest new features or enhancements
- 📝 Improve documentation
- 🔧 Submit bug fixes
- ✨ Add new features
- 🧪 Write tests
- 🌍 Add translations

### Contribution Process

1. **Fork the Repository**
   ```bash
   # Click the Fork button on GitHub
   # Clone your fork
   git clone https://github.com/YOUR_USERNAME/smart-mobile-lpr.git
   cd smart-mobile-lpr
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/AmazingFeature
   # Or for bug fixes
   git checkout -b fix/BugDescription
   ```

3. **Make Your Changes**
   - Write clean, documented code
   - Follow the existing code style
   - Add tests for new features
   - Update documentation as needed

4. **Test Your Changes**
   ```bash
   # Run tests
   flutter test
   
   # Test on multiple platforms
   flutter run -d android
   flutter run -d ios
   flutter run -d chrome
   ```

5. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "Add: Brief description of changes"
   
   # Use conventional commit messages:
   # feat: New feature
   # fix: Bug fix
   # docs: Documentation changes
   # style: Code style changes
   # refactor: Code refactoring
   # test: Adding tests
   # chore: Maintenance tasks
   ```

6. **Push to Your Fork**
   ```bash
   git push origin feature/AmazingFeature
   ```

7. **Open a Pull Request**
   - Go to the original repository on GitHub
   - Click "New Pull Request"
   - Select your fork and branch
   - Describe your changes clearly
   - Reference any related issues

### Code Review Process

- All submissions require review
- We may suggest changes or improvements
- Once approved, your PR will be merged
- Your contribution will be acknowledged

### Coding Standards

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Write comments for complex logic
- Keep functions small and focused
- Use const constructors where possible

### Commit Message Guidelines

Format: `<type>: <subject>`

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style (formatting, missing semicolons, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance, dependencies, configuration

**Examples:**
```
feat: Add dark mode support
fix: Camera permission crash on Android 13
docs: Update installation instructions
refactor: Simplify vehicle service logic
test: Add unit tests for auth service
```

### Code of Conduct

- Be respectful and inclusive
- Welcome newcomers and help them learn
- Accept constructive criticism gracefully
- Focus on what's best for the community
- Show empathy towards others

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Somkheart K.**
- GitHub: [@somkheartk](https://github.com/somkheartk)
- Repository: [smart-mobile-lpr](https://github.com/somkheartk/smart-mobile-lpr)

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- Material Design for the design system
- fl_chart for beautiful charts
- All contributors and testers

## 📞 Support

For support, email somkheart@example.com or open an issue in the repository.

## 🗺️ Roadmap

### Version 2.0 (Planned)
- [ ] Real Camera ML Integration
  - [ ] Integrate TensorFlow Lite model
  - [ ] Support multiple languages (Thai, English, etc.)
  - [ ] Improve detection accuracy
- [ ] Backend API Development
  - [ ] RESTful API with authentication
  - [ ] Real-time data synchronization
  - [ ] Cloud storage integration
- [ ] Real-time Notifications
  - [ ] Push notifications for violations
  - [ ] Alert system for operators
  - [ ] Email notifications

### Version 2.5 (Planned)
- [ ] Multi-language Support
  - [ ] Thai (current)
  - [ ] English
  - [ ] Chinese
- [ ] Dark Mode
  - [ ] System theme detection
  - [ ] Manual theme toggle
  - [ ] OLED-friendly dark mode
- [ ] Export Reports
  - [ ] PDF generation
  - [ ] Excel/CSV export
  - [ ] Customizable report templates

### Version 3.0 (Future)
- [ ] Advanced Analytics
  - [ ] Predictive analytics
  - [ ] Traffic pattern analysis
  - [ ] Heat maps
- [ ] User Management System
  - [ ] Multi-user support
  - [ ] User profiles and preferences
  - [ ] Activity logs
- [ ] Role-based Access Control
  - [ ] Admin, Supervisor, Operator roles
  - [ ] Permission management
  - [ ] Audit trails

### Long-term Goals
- [ ] Integration with law enforcement databases
- [ ] API for third-party applications
- [ ] Mobile app for field officers
- [ ] AI-powered violation prediction
- [ ] Blockchain for data integrity

## 📋 Known Limitations

### Current Version

1. **Mock Data Only**
   - Application currently uses simulated data
   - No real backend integration
   - Detection results are randomly generated

2. **No Persistent Storage**
   - Data is lost on app restart
   - No local database implementation
   - Changes are not saved between sessions

3. **Limited ML Capabilities**
   - Camera detection is simulated
   - No real machine learning model
   - Recognition accuracy not applicable

4. **Single User Mode**
   - No multi-user support
   - Basic authentication only
   - No user roles or permissions

5. **Language Support**
   - Thai language only
   - No internationalization (i18n) implemented

### Workarounds

- For production use, integrate with a real backend API
- Implement local storage using SQLite or Hive
- Add ML model using TensorFlow Lite or cloud APIs
- Extend authentication system for multi-user support

## 📊 Project Statistics

- **Lines of Code**: ~5,000+
- **Number of Screens**: 7
- **Reusable Widgets**: 10+
- **Services**: 4
- **Models**: 5
- **Supported Platforms**: 6 (Android, iOS, Web, Windows, macOS, Linux)

## 🌟 Features Comparison

| Feature | Current Version | Planned (v2.0) | Future (v3.0) |
|---------|----------------|----------------|---------------|
| Mock Data | ✅ | ✅ | ✅ |
| Real API | ❌ | ✅ | ✅ |
| Local Storage | ❌ | ✅ | ✅ |
| ML Detection | ❌ | ✅ | ✅ |
| Multi-language | ❌ | ✅ | ✅ |
| Dark Mode | ❌ | ✅ | ✅ |
| Export Reports | ❌ | ✅ | ✅ |
| User Management | ❌ | ❌ | ✅ |
| RBAC | ❌ | ❌ | ✅ |
| Cloud Sync | ❌ | ❌ | ✅ |

## 📚 Additional Resources

### Official Documentation
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design Guidelines](https://m3.material.io/)

### Tutorials & Guides
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Dart Package Site](https://pub.dev/)
- [Flutter Widget Catalog](https://docs.flutter.dev/ui/widgets)

### Community
- [Flutter Community](https://flutter.dev/community)
- [Stack Overflow - Flutter](https://stackoverflow.com/questions/tagged/flutter)
- [Flutter Discord](https://discord.gg/flutter)
- [Reddit - r/FlutterDev](https://www.reddit.com/r/FlutterDev/)

### Tools & Extensions
- [Flutter DevTools](https://docs.flutter.dev/tools/devtools)
- [VS Code Flutter Extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
- [Android Studio Flutter Plugin](https://plugins.jetbrains.com/plugin/9212-flutter)

### Related Projects
- [Flutter Samples](https://github.com/flutter/samples)
- [Awesome Flutter](https://github.com/Solido/awesome-flutter)
- [Flutter Community Packages](https://github.com/fluttercommunity)

## 📜 Changelog

### Version 1.0.0 (Current)
- ✅ Initial release
- ✅ Login/Logout functionality
- ✅ Dashboard with statistics
- ✅ Camera page with mock detection
- ✅ Vehicle list with search and filter
- ✅ Statistics page with charts
- ✅ Settings page
- ✅ Thai language support
- ✅ Material Design 3 theme
- ✅ Kanit font integration
- ✅ Environment variable configuration
- ✅ Cross-platform support (Android, iOS, Web, Desktop)

### Coming in Next Release
- Backend API integration
- Real ML model for plate detection
- Local database storage
- Enhanced error handling
- Performance optimizations

For detailed version history, see [GitHub Releases](https://github.com/somkheartk/smart-mobile-lpr/releases).

---

**Made with ❤️ using Flutter**

 
 