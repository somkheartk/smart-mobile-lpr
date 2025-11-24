# โครงสร้างโปรเจกต์ LPR Monitor

## โครงสร้างไฟล์ที่สร้างแล้ว

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart       # สีต่างๆ ที่ใช้ในแอป
│   │   ├── app_strings.dart      # ข้อความทั้งหมด
│   │   └── app_dimensions.dart   # ขนาด padding, radius, etc.
│   └── theme/
│       └── app_theme.dart        # Theme configuration
├── widgets/
│   ├── stat_card.dart            # Widget การ์ดสถิติ
│   ├── vehicle_card.dart         # Widget การ์ดรถ
│   └── section_header.dart       # Widget หัวข้อ section
├── pages/
│   ├── login_page.dart           # หน้า Login (สร้างแล้ว)
│   ├── main_navigator.dart       # Bottom Navigation (สร้างแล้ว)
│   ├── dashboard_page.dart       # หน้าหลัก (ต้องสร้าง)
│   ├── statistics_page.dart      # หน้าสถิติ (ต้องสร้าง)
│   ├── vehicle_list_page.dart    # หน้ารายการรถ (ต้องสร้าง)
│   └── settings_page.dart        # หน้าตั้งค่า (ต้องสร้าง)
└── main.dart                     # Entry point (ต้องแก้ไข)
```

## Font Kanit
- ดาวน์โหลดแล้วที่ `assets/fonts/`
- เพิ่ม configuration ใน `pubspec.yaml` แล้ว

## ขั้นตอนต่อไป

### 1. คัดลอกโค้ดจาก main.dart เดิม

ต้องแยกคลาสเหล่านี้จาก `main.dart` เดิม ไปสร้างเป็นไฟล์ใหม่:

- `LPRDashboard` (บรรทัด ~285) → `pages/dashboard_page.dart`
- `StatisticsPage` (บรรทัด ~947) → `pages/statistics_page.dart`  
- `VehicleListPage` (บรรทัด ~1403) → `pages/vehicle_list_page.dart`
- `SettingsPage` (บรรทัด ~1633) → `pages/settings_page.dart`

### 2. แก้ไข main.dart

แทนที่เนื้อหาใน `main.dart` ด้วย:

\`\`\`dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LPR Monitor',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
\`\`\`

### 3. เพิ่ม import ในแต่ละหน้า

แต่ละหน้าต้อง import:
- `package:flutter/material.dart`
- `package:fl_chart/fl_chart.dart` (ถ้ามีกราฟ)
- Constants และ widgets ที่จำเป็น

### 4. เปลี่ยนชื่อคลาส

- `LPRDashboard` → `DashboardPage` 
- เก็บชื่ออื่นๆไว้เหมือนเดิม

## การใช้งาน Constants

แทนที่:
- สีโดยตรง → `AppColors.primaryBlue`
- ข้อความโดยตรง → `AppStrings.appName`
- ตัวเลข padding → `AppDimensions.paddingMedium`

## Theme

Theme ถูก config แล้วที่ `app_theme.dart` ใช้ font Kanit ทั้งหมด

\`\`\`dart
// ใช้ theme colors
color: Theme.of(context).colorScheme.primary

// ใช้ text styles
style: Theme.of(context).textTheme.headlineMedium
\`\`\`

## Widgets ที่สร้างไว้แล้ว

### StatCard
\`\`\`dart
StatCard(
  title: 'จำนวนทั้งหมด',
  value: '2,847',
  color: AppColors.cardTeal,
  icon: Icons.directions_car,
)
\`\`\`

### VehicleCard
\`\`\`dart
VehicleCard(
  plate: 'ภ4 ทช9498',
  type: 'รถเก๋ง',
  violation: 'ขับไม่มี ภ.ผ.20',
  isNormal: true,
)
\`\`\`

### SectionHeader
\`\`\`dart
SectionHeader(
  title: 'รถตรวจพบล่าสุด',
  onViewAll: () {},
)
\`\`\`
