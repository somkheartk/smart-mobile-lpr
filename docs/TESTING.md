# คู่มือการทดสอบ (Testing Guide)

คู่มือนี้จะอธิบายวิธีการรันและเขียนเทสต์สำหรับแอปพลิเคชัน

## รันเทสต์

### รันเทสต์ทั้งหมด
```bash
flutter test
```

### รันเทสต์ไฟล์เดียว
```bash
flutter test test/services/auth_service_test.dart
```

### รันเทสต์พร้อม Coverage
```bash
flutter test --coverage

# สร้างรายงาน HTML (ต้องติดตั้ง lcov)
genhtml coverage/lcov.info -o coverage/html

# เปิดรายงาน
open coverage/html/index.html  # macOS
xdg-open coverage/html/index.html  # Linux
start coverage/html/index.html  # Windows
```

## ประเภทของเทสต์

### 1. Unit Tests
ทดสอบฟังก์ชันหรือคลาสแยกส่วน

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
    
    test('ควรเข้าสู่ระบบสำเร็จด้วย credentials ที่ถูกต้อง', () async {
      final result = await authService.login('admin', 'admin123');
      expect(result, isTrue);
      expect(authService.isAuthenticated, isTrue);
    });
    
    test('ควรปฏิเสธ credentials ที่ผิด', () async {
      final result = await authService.login('wrong', 'wrong');
      expect(result, isFalse);
      expect(authService.isAuthenticated, isFalse);
    });
    
    test('ควรออกจากระบบได้', () {
      authService.logout();
      expect(authService.isAuthenticated, isFalse);
      expect(authService.currentUser, isNull);
    });
  });
}
```

### 2. Widget Tests
ทดสอบ UI components

```dart
// test/widgets/stat_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_lpr/widgets/stat_card.dart';

void main() {
  testWidgets('StatCard ควรแสดงค่าที่ถูกต้อง', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StatCard(
            title: 'ทั้งหมด',
            value: '100',
            color: Colors.blue,
            icon: Icons.car_rental,
          ),
        ),
      ),
    );
    
    // ตรวจสอบว่าข้อความแสดงอยู่
    expect(find.text('ทั้งหมด'), findsOneWidget);
    expect(find.text('100'), findsOneWidget);
    
    // ตรวจสอบว่า icon แสดงอยู่
    expect(find.byIcon(Icons.car_rental), findsOneWidget);
  });
  
  testWidgets('StatCard ควรมีสีที่ถูกต้อง', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatCard(
            key: const Key('test_stat_card'),
            title: 'Test',
            value: '50',
            color: Colors.red,
            icon: Icons.warning,
          ),
        ),
      ),
    );
    
    // ใช้ key เพื่อหา widget เป้าหมายอย่างแม่นยำ
    final statCard = tester.widget<StatCard>(
      find.byKey(const Key('test_stat_card')),
    );
    
    expect(statCard.color, Colors.red);
  });
}
```

### 3. Integration Tests
ทดสอบการทำงานของแอปทั้งหมด

```dart
// integration_test/app_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mobile_lpr/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ทดสอบ login flow', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // หา username field และกรอก
    final usernameField = find.byKey(const Key('username_field'));
    await tester.enterText(usernameField, 'admin');
    
    // หา password field และกรอก
    final passwordField = find.byKey(const Key('password_field'));
    await tester.enterText(passwordField, 'admin123');
    
    // กดปุ่ม login
    final loginButton = find.byKey(const Key('login_button'));
    await tester.tap(loginButton);
    await tester.pumpAndSettle();
    
    // ตรวจสอบว่าเข้าสู่หน้า dashboard แล้ว
    expect(find.text('แดชบอร์ด'), findsOneWidget);
  });
}
```

รัน Integration Tests:
```bash
flutter test integration_test/app_test.dart
```

## Best Practices

### 1. ใช้ setUp และ tearDown
```dart
void main() {
  late MyService service;
  
  setUp(() {
    // เตรียมข้อมูลก่อนแต่ละเทสต์
    service = MyService();
  });
  
  tearDown(() {
    // ทำความสะอาดหลังแต่ละเทสต์
    service.dispose();
  });
  
  test('...', () {
    // เทสต์
  });
}
```

### 2. ใช้ group เพื่อจัดกลุ่มเทสต์
```dart
void main() {
  group('AuthService', () {
    group('login', () {
      test('ควรสำเร็จด้วย valid credentials', () {});
      test('ควรล้มเหลวด้วย invalid credentials', () {});
    });
    
    group('logout', () {
      test('ควรล้างข้อมูล session', () {});
    });
  });
}
```

### 3. ใช้ Mocks สำหรับ dependencies
```dart
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ApiService])
void main() {
  test('ควรดึงข้อมูลจาก API', () async {
    // สร้าง mock
    final mockApi = MockApiService();
    
    // กำหนดพฤติกรรมของ mock
    when(mockApi.fetchData()).thenAnswer((_) async => ['data']);
    
    // ใช้ mock ในเทสต์
    final result = await mockApi.fetchData();
    expect(result, ['data']);
    
    // ตรวจสอบว่า method ถูกเรียก
    verify(mockApi.fetchData()).called(1);
  });
}
```

## Matchers ที่ใช้บ่อย

```dart
// เท่ากับ
expect(actual, equals(expected));
expect(actual, expected);  // เหมือนกัน

// ไม่เท่ากับ
expect(actual, isNot(expected));

// Null
expect(value, isNull);
expect(value, isNotNull);

// Boolean
expect(value, isTrue);
expect(value, isFalse);

// Numbers
expect(value, greaterThan(5));
expect(value, lessThan(10));
expect(value, inInclusiveRange(5, 10));

// Strings
expect(str, contains('text'));
expect(str, startsWith('pre'));
expect(str, endsWith('fix'));
expect(str, matches(RegExp(r'\d+')));

// Collections
expect(list, isEmpty);
expect(list, isNotEmpty);
expect(list, hasLength(3));
expect(list, contains(item));

// Types
expect(value, isA<String>());
expect(value, isInstanceOf<MyClass>());

// Async
await expectLater(future, completes);
await expectLater(future, throwsException);
await expectLater(stream, emits(value));
```

## Widget Testing Tips

### หา Widgets
```dart
// หาด้วยข้อความ
find.text('Hello');

// หาด้วย Key
find.byKey(const Key('my_key'));

// หาด้วยประเภท
find.byType(TextField);

// หาด้วย Icon
find.byIcon(Icons.add);

// หา Widget ที่ตรงกับเงื่อนไข
find.byWidgetPredicate((widget) => widget is Text && widget.data == 'Hello');
```

### Interact กับ Widgets
```dart
// กรอกข้อความ
await tester.enterText(find.byType(TextField), 'text');

// แตะ/กด
await tester.tap(find.byType(ElevatedButton));

// Drag
await tester.drag(find.byType(ListView), const Offset(0, -200));

// Long press
await tester.longPress(find.text('Item'));
```

### รอให้ Animation เสร็จ
```dart
// รอจนไม่มี animation
await tester.pumpAndSettle();

// รอหนึ่ง frame
await tester.pump();

// รอระยะเวลาที่กำหนด
await tester.pump(const Duration(seconds: 1));
```

## Coverage Goals

- **Unit Tests**: ≥ 80%
- **Widget Tests**: ≥ 70%
- **Integration Tests**: Critical user flows

## Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [flutter_test Package](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
- [Mockito Package](https://pub.dev/packages/mockito)
- [Integration Testing](https://docs.flutter.dev/testing/integration-tests)
