# คู่มือการพัฒนา (Development Guide)

คู่มือนี้จะอธิบายวิธีตั้งค่า environment, code style, และการเพิ่มฟีเจอร์ใหม่

## การตั้งค่า Development Environment

### 1. ติดตั้ง Flutter SDK

```bash
# ดาวน์โหลด Flutter SDK จาก https://flutter.dev
# เพิ่ม Flutter ลงใน PATH
export PATH="$PATH:`pwd`/flutter/bin"

# ตรวจสอบการติดตั้ง
flutter doctor
```

### 2. ติดตั้ง IDE Extensions

**VS Code:**
- Flutter
- Dart
- Flutter Widget Snippets

**Android Studio:**
- Flutter Plugin
- Dart Plugin

### 3. Clone และตั้งค่าโปรเจกต์

```bash
git clone https://github.com/somkheartk/smart-mobile-lpr.git
cd smart-mobile-lpr

# คัดลอกไฟล์ environment
cp .env.example .env

# ติดตั้ง dependencies
flutter pub get

# รัน code generation (ถ้าจำเป็น)
flutter pub run build_runner build
```

## Code Style Guidelines

### การตั้งชื่อไฟล์และคลาส

- **ไฟล์**: ใช้ `snake_case` เช่น `vehicle_service.dart`
- **คลาส**: ใช้ `PascalCase` เช่น `VehicleService`
- **ตัวแปร**: ใช้ `camelCase` เช่น `currentUser`
- **Constants**: ใช้ `lowerCamelCase` กับ `const` เช่น `const primaryColor`
- **Private Members**: ขึ้นต้นด้วย underscore เช่น `_privateMethod`

### โครงสร้างโค้ด

```dart
import 'package:flutter/material.dart';

// Constants และ Types ก่อน

// Public members ก่อน private members

class MyClass {
  // Static members
  static const String constantValue = 'value';
  
  // Instance variables
  final String publicVariable;
  final String _privateVariable;
  
  // Constructor
  MyClass({
    required this.publicVariable,
    required String privateVariable,
  }) : _privateVariable = privateVariable;
  
  // Public methods
  void publicMethod() {
    // ...
  }
  
  // Private methods
  void _privateMethod() {
    // ...
  }
}
```

## การเพิ่มฟีเจอร์ใหม่

### 1. สร้าง Model (ถ้าจำเป็น)

```dart
// lib/models/my_model.dart
class MyModel {
  final String id;
  final String name;
  
  MyModel({
    required this.id,
    required this.name,
  });
  
  // จาก JSON
  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      id: json['id'],
      name: json['name'],
    );
  }
  
  // เป็น JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
```

### 2. สร้าง Service

```dart
// lib/services/my_service.dart
class MyService {
  // Singleton pattern
  static final MyService _instance = MyService._internal();
  factory MyService() => _instance;
  MyService._internal();
  
  // Methods
  Future<List<MyModel>> fetchData() async {
    // ดึงข้อมูล
    return [];
  }
}
```

### 3. สร้าง Widget

```dart
// lib/widgets/my_widget.dart
class MyWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  
  const MyWidget({
    super.key,
    required this.title,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(title),
    );
  }
}
```

### 4. สร้าง Page

```dart
// lib/pages/my_page.dart
class MyPage extends StatefulWidget {
  const MyPage({super.key});
  
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    // Initialize
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      body: Container(),
    );
  }
  
  @override
  void dispose() {
    // Cleanup
    super.dispose();
  }
}
```

## Hot Reload & Hot Restart

### Hot Reload (r)
- รีเฟรช UI อย่างรวดเร็ว โดยไม่สูญเสีย state
- ใช้สำหรับการเปลี่ยนแปลง UI
- กด `r` ใน terminal หรือ `Ctrl+S` ใน IDE

### Hot Restart (R)
- รีสตาร์ทแอปเต็มรูปแบบ พร้อมรีเซ็ต state
- ใช้สำหรับการเปลี่ยนแปลง logic หรือแก้ปัญหา state
- กด `R` ใน terminal

## Debugging Tips

### 1. Print Debugging
```dart
debugPrint('ข้อความ debug: $variable');
```

### 2. Flutter DevTools
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

### 3. Widget Inspector
- กด `p` ใน terminal เพื่อแสดง performance overlay
- กด `w` เพื่อเปิด/ปิด widget inspector

### 4. Debug Console
- ดู logs ใน IDE debug console
- กรอง logs ตามระดับ

## Best Practices

### 1. ใช้ const constructors
```dart
// ดี ✅
const Text('Hello')

// ไม่ดี ❌
Text('Hello')
```

### 2. หลีกเลี่ยงการ rebuild widgets ที่ไม่จำเป็น
```dart
// ใช้ const widgets เมื่อเป็นไปได้
const StatCard(title: 'Total', value: '100', ...)

// แบ่ง widgets เป็นส่วนเล็กๆ
// ใช้ Keys สำหรับ list items
```

### 3. Lazy Loading Lists
```dart
// ใช้ ListView.builder แทน ListView
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ItemWidget(item: items[index]);
  },
)
```

### 4. หลีกเลี่ยง operations ที่หนักใน build method
```dart
// ไม่ดี ❌ - คำนวณใน build method
@override
Widget build(BuildContext context) {
  final expensiveValue = calculateExpensiveValue();
  return Text(expensiveValue);
}

// ดี ✅ - คำนวณใน initState
late String cachedValue;

@override
void initState() {
  super.initState();
  cachedValue = calculateExpensiveValue();
}
```

## การใช้งาน Constants

```dart
// ใช้ constants แทนการ hardcode ค่า
import 'package:mobile_lpr/core/constants/app_colors.dart';
import 'package:mobile_lpr/core/constants/app_strings.dart';
import 'package:mobile_lpr/core/constants/app_dimensions.dart';

// ดี ✅
color: AppColors.primaryBlue
text: AppStrings.appName
padding: AppDimensions.paddingMedium

// ไม่ดี ❌
color: Color(0xFF4A90E2)
text: 'LPR Monitor'
padding: 16.0
```

## Resources

- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Best Practices](https://flutter.dev/docs/development/best-practices)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
