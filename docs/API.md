# API Documentation

เอกสารนี้อธิบาย Services และ Models ที่ใช้ในแอปพลิเคชัน

## Services

### AuthService

บริหารจัดการการ authentication และ session

```dart
// Singleton instance
final authService = AuthService();

// Login
Future<bool> login(String username, String password);
// Returns: true ถ้า login สำเร็จ

// Check authentication status
bool get isAuthenticated;

// Get current user
User? get currentUser;

// Logout
void logout();
```

**ตัวอย่างการใช้งาน:**
```dart
// Login
final success = await AuthService().login('admin', 'admin123');
if (success) {
  print('เข้าสู่ระบบสำเร็จ');
}

// ตรวจสอบสถานะ
if (AuthService().isAuthenticated) {
  final user = AuthService().currentUser;
  print('User: ${user?.fullName}');
}

// Logout
AuthService().logout();
```

### VehicleService

จัดการข้อมูลรถยนต์ที่ตรวจพบ

```dart
final vehicleService = VehicleService();

// Get all vehicles
List<Vehicle> getVehicles();

// Search vehicles by plate number
List<Vehicle> searchVehicles(String query);

// Filter by status
List<Vehicle> filterByStatus(VehicleStatus status);

// Filter by date
List<Vehicle> filterByDate(DateTime date);

// Add new vehicle detection
void addVehicle(Vehicle vehicle);

// Get vehicle by ID
Vehicle? getVehicleById(String id);
```

**ตัวอย่างการใช้งาน:**
```dart
// ดึงข้อมูลรถทั้งหมด
final vehicles = VehicleService().getVehicles();

// ค้นหารถ
final results = VehicleService().searchVehicles('กก 1234');

// กรองตามสถานะ
final violations = VehicleService().filterByStatus(VehicleStatus.violation);

// เพิ่มรถใหม่
final newVehicle = Vehicle(
  id: 'V001',
  licensePlate: 'กก 1234',
  type: VehicleType.car,
  detectedAt: DateTime.now(),
  status: VehicleStatus.normal,
  operator: 'OP001',
);
VehicleService().addVehicle(newVehicle);
```

### StatisticsService

จัดการข้อมูลสถิติและรายงาน

```dart
final statsService = StatisticsService();

// Get today's statistics
Statistics getTodayStatistics();

// Get monthly statistics
Statistics getMonthlyStatistics();

// Get detection trends (for charts)
List<DetectionData> getDetectionTrends(int days);

// Get violation statistics
Map<String, int> getViolationStats();

// Get operator performance
List<OperatorPerformance> getOperatorPerformance();
```

**ตัวอย่างการใช้งาน:**
```dart
// สถิติวันนี้
final todayStats = StatisticsService().getTodayStatistics();
print('ตรวจพบวันนี้: ${todayStats.totalDetections}');

// สถิติรายเดือน
final monthlyStats = StatisticsService().getMonthlyStatistics();
print('ตรวจพบเดือนนี้: ${monthlyStats.totalDetections}');

// ข้อมูลสำหรับกราฟ
final trends = StatisticsService().getDetectionTrends(7); // 7 วันล่าสุด
```

### OperatorService

จัดการข้อมูลเจ้าหน้าที่

```dart
final operatorService = OperatorService();

// Get all operators
List<Operator> getOperators();

// Get operator by ID
Operator? getOperatorById(String id);

// Get operator performance
OperatorPerformance getOperatorPerformance(String operatorId);
```

## Models

### User

ข้อมูลผู้ใช้งานระบบ

```dart
class User {
  final String id;
  final String username;
  final String fullName;
  final String role;  // 'admin', 'supervisor', 'operator'
  final String? profileImage;
  
  const User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.role,
    this.profileImage,
  });
}
```

### Vehicle

ข้อมูลรถยนต์ที่ตรวจพบ

```dart
class Vehicle {
  final String id;
  final String licensePlate;
  final VehicleType type;
  final DateTime detectedAt;
  final VehicleStatus status;
  final String? violationType;
  final String operator;
  final String? location;
  final String? imageUrl;
  
  const Vehicle({
    required this.id,
    required this.licensePlate,
    required this.type,
    required this.detectedAt,
    required this.status,
    this.violationType,
    required this.operator,
    this.location,
    this.imageUrl,
  });
}

enum VehicleType {
  car,        // รถเก๋ง
  pickup,     // รถกระบะ
  van,        // รถตู้
  truck,      // รถบรรทุก
  motorcycle, // มอเตอร์ไซค์
}

enum VehicleStatus {
  normal,     // ปกติ
  violation,  // มีความผิด
}
```

### Statistics

ข้อมูลสถิติ

```dart
class Statistics {
  final int totalDetections;      // จำนวนตรวจพบทั้งหมด
  final int normalVehicles;       // รถปกติ
  final int violationVehicles;    // รถที่มีความผิด
  final double violationRate;     // อัตราการฝ่าฝืน (%)
  final DateTime period;          // ช่วงเวลา
  
  const Statistics({
    required this.totalDetections,
    required this.normalVehicles,
    required this.violationVehicles,
    required this.violationRate,
    required this.period,
  });
}
```

### DetectionData

ข้อมูลสำหรับกราฟแนวโน้ม

```dart
class DetectionData {
  final DateTime date;
  final int count;
  final int violations;
  
  const DetectionData({
    required this.date,
    required this.count,
    required this.violations,
  });
}
```

### Operator

ข้อมูลเจ้าหน้าที่

```dart
class Operator {
  final String id;
  final String name;
  final String role;
  final int detectionsToday;
  final int detectionsMonth;
  
  const Operator({
    required this.id,
    required this.name,
    required this.role,
    required this.detectionsToday,
    required this.detectionsMonth,
  });
}
```

### OperatorPerformance

สถิติประสิทธิภาพของเจ้าหน้าที่

```dart
class OperatorPerformance {
  final String operatorId;
  final String operatorName;
  final int totalDetections;
  final int violations;
  final double accuracy;
  final DateTime period;
  
  const OperatorPerformance({
    required this.operatorId,
    required this.operatorName,
    required this.totalDetections,
    required this.violations,
    required this.accuracy,
    required this.period,
  });
}
```

### ApiResponse<T>

Wrapper สำหรับ API responses

```dart
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;
  
  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
  });
  
  factory ApiResponse.success(T data) {
    return ApiResponse(
      success: true,
      data: data,
    );
  }
  
  factory ApiResponse.error(String message, [int? statusCode]) {
    return ApiResponse(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }
}
```

## Error Handling

### Service Exceptions

```dart
class ServiceException implements Exception {
  final String message;
  final int? code;
  
  ServiceException(this.message, [this.code]);
  
  @override
  String toString() => message;
}
```

### การจัดการ Errors

```dart
try {
  final vehicles = VehicleService().getVehicles();
  // ...
} on ServiceException catch (e) {
  print('Error: ${e.message}');
  // แสดง error dialog หรือ snackbar
} catch (e) {
  print('Unexpected error: $e');
}
```

## Future Enhancements

เมื่อมี Backend API จริง Services เหล่านี้จะมีการเปลี่ยนแปลงเป็น:

```dart
class VehicleService {
  final ApiClient _apiClient;
  
  // จาก sync เป็น async
  Future<List<Vehicle>> getVehicles() async {
    final response = await _apiClient.get('/vehicles');
    return (response.data as List)
        .map((json) => Vehicle.fromJson(json))
        .toList();
  }
  
  Future<void> addVehicle(Vehicle vehicle) async {
    await _apiClient.post('/vehicles', data: vehicle.toJson());
  }
}
```

## Testing Services

ดู [TESTING.md](TESTING.md) สำหรับตัวอย่างการเขียนเทสต์สำหรับ Services
