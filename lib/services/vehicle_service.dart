import '../models/vehicle.dart';
import '../models/api_response.dart';

class VehicleService {
  static final VehicleService _instance = VehicleService._internal();
  factory VehicleService() => _instance;
  VehicleService._internal();

  Future<ApiResponse<List<Vehicle>>> getVehicles({
    int page = 1,
    int limit = 20,
    bool? isViolation,
    VehicleType? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock data
      final vehicles = _generateMockVehicles(limit);

      // Filter by violation
      List<Vehicle> filtered = vehicles;
      if (isViolation != null) {
        filtered = filtered.where((v) => v.isViolation == isViolation).toList();
      }

      // Filter by type
      if (type != null) {
        filtered = filtered.where((v) => v.type == type).toList();
      }

      return ApiResponse.success(filtered);
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<ApiResponse<Vehicle>> getVehicleById(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final vehicle = Vehicle(
        id: id,
        plateNumber: 'ภ4 ทช9498',
        type: VehicleType.car,
        location: 'ถนนสุขุมวิท กรุงเทพฯ',
        detectedAt: DateTime.now(),
        isViolation: true,
        violationType: 'ขับเร็ว',
      );

      return ApiResponse.success(vehicle);
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<Vehicle>>> getRecentVehicles({int limit = 10}) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final vehicles = _generateMockVehicles(limit);
      return ApiResponse.success(vehicles);
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<Vehicle>>> searchVehicles(String query) async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      final vehicles = _generateMockVehicles(
        10,
      ).where((v) => v.plateNumber.contains(query)).toList();
      return ApiResponse.success(vehicles);
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  List<Vehicle> _generateMockVehicles(int count) {
    final plates = [
      'ภ4 ทช9498',
      'กธ ท5 ถพร',
      'ฮร ฮ8 อำเภอ',
      'นข 1234',
      'กก 5678',
      'ขข 9012',
      'คค 3456',
      'งง 7890',
    ];

    final types = [
      VehicleType.car,
      VehicleType.truck,
      VehicleType.van,
      VehicleType.pickup,
    ];

    final violations = [
      'ขับเร็ว',
      'บรรทุกน้ำหนักเกิน',
      'ขับไม่มี ภ.ผ.20',
      'ไม่คาดเข็มขัด',
      'ไม่มีป้ายแดง',
    ];

    return List.generate(count, (index) {
      final isViolation = index % 3 == 0;
      return Vehicle(
        id: 'v_$index',
        plateNumber: plates[index % plates.length],
        type: types[index % types.length],
        location: 'ถนนสุขุมวิท กรุงเทพฯ',
        detectedAt: DateTime.now().subtract(Duration(minutes: index * 5)),
        isViolation: isViolation,
        violationType: isViolation
            ? violations[index % violations.length]
            : null,
      );
    });
  }
}
