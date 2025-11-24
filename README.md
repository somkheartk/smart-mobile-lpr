# 🚗 Smart Mobile LPR (License Plate Recognition)

ระบบตรวจจับและติดตามป้ายทะเบียนรถอัจฉริยะ พัฒนาด้วย Flutter สำหรับการทำงานแบบ Cross-Platform

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

## 📱 Screenshots

<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="screenshots/login.png" width="200" alt="Login"/><br/>
        <b>Login Page</b><br/>
        <sub>หน้าเข้าสู่ระบบ</sub>
      </td>
      <td align="center">
        <img src="screenshots/dashboard.png" width="200" alt="Dashboard"/><br/>
        <b>Dashboard</b><br/>
        <sub>แสดงสถิติรวม</sub>
      </td>
      <td align="center">
        <img src="screenshots/camera.png" width="200" alt="Camera"/><br/>
        <b>Camera Scanner</b><br/>
        <sub>สแกนป้ายทะเบียน</sub>
      </td>
    </tr>
    <tr>
      <td align="center">
        <img src="screenshots/vehicle_list.png" width="200" alt="Vehicle List"/><br/>
        <b>Vehicle List</b><br/>
        <sub>รายการรถทั้งหมด</sub>
      </td>
      <td align="center">
        <img src="screenshots/statistics.png" width="200" alt="Statistics"/><br/>
        <b>Statistics</b><br/>
        <sub>สถิติโดยละเอียด</sub>
      </td>
      <td align="center">
        <img src="screenshots/settings.png" width="200" alt="Settings"/><br/>
        <b>Settings</b><br/>
        <sub>การตั้งค่า</sub>
      </td>
    </tr>
  </table>
</div>

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
```

### Fonts
- **Kanit** - Thai Font (Regular, Medium, Bold)

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.9.2 or higher
- Dart SDK 3.9.2 or higher
- Android Studio / VS Code
- Git

### Installation

1. **Clone Repository**
```bash
git clone https://github.com/somkheartk/smart-mobile-lpr.git
cd smart-mobile-lpr
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Run Application**
```bash
flutter run
```

Choose your target platform:
- `[1]` Windows (Desktop)
- `[2]` Chrome (Web)
- `[3]` Edge (Web)
- Android/iOS (with connected device)

### Demo Credentials
```
Username: admin
Password: admin123

-- OR --

Username: operator1
Password: operator123
```

## 📁 Project Structure

```
mobile_lpr/
├── android/                    # Android native code
├── ios/                        # iOS native code
├── lib/
│   ├── core/
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

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
```

## 📦 Build

### Android APK
```bash
flutter build apk --release
```

### iOS IPA
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Windows
```bash
flutter build windows --release
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

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

- [ ] Real Camera ML Integration
- [ ] Backend API Development
- [ ] Real-time Notifications
- [ ] Multi-language Support
- [ ] Dark Mode
- [ ] Export Reports (PDF/Excel)
- [ ] Advanced Analytics
- [ ] User Management System
- [ ] Role-based Access Control

---

**Made with ❤️ using Flutter**

 
 