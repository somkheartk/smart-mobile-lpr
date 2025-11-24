import '../models/statistics.dart';
import '../models/api_response.dart';

class StatisticsService {
  static final StatisticsService _instance = StatisticsService._internal();
  factory StatisticsService() => _instance;
  StatisticsService._internal();

  Future<ApiResponse<DashboardStats>> getDashboardStats() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final stats = DashboardStats(
        totalVehicles: 2847,
        todayCount: 28,
        monthCount: 12,
        accuracy: 98.7,
      );

      return ApiResponse.success(stats);
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<ViolationStats>>> getViolationStats() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final stats = [
        ViolationStats(type: 'ขับเร็ว', count: 156, percentage: 35.0),
        ViolationStats(type: 'เก๋งไม่มี ภ.ผ.20', count: 112, percentage: 25.0),
        ViolationStats(type: 'บรรทุกน้ำหนักเกิน', count: 89, percentage: 20.0),
        ViolationStats(type: 'อื่นๆ', count: 89, percentage: 20.0),
      ];

      return ApiResponse.success(stats);
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<DetectionData>>> getHourlyDetection() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final data = [
        DetectionData(time: '10:00', count: 40),
        DetectionData(time: '11:00', count: 80),
        DetectionData(time: '12:00', count: 120),
        DetectionData(time: '13:00', count: 150),
        DetectionData(time: '14:00', count: 180),
        DetectionData(time: '15:00', count: 140),
        DetectionData(time: '16:00', count: 100),
        DetectionData(time: '17:00', count: 70),
        DetectionData(time: '18:00', count: 50),
      ];

      return ApiResponse.success(data);
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<MonthlyStats>>> getMonthlyStats() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final data = [
        MonthlyStats(month: 'ม.ค.', count: 250),
        MonthlyStats(month: 'ก.พ.', count: 300),
        MonthlyStats(month: 'มี.ค.', count: 280),
        MonthlyStats(month: 'เม.ย.', count: 320),
        MonthlyStats(month: 'พ.ค.', count: 350),
        MonthlyStats(month: 'มิ.ย.', count: 290),
      ];

      return ApiResponse.success(data);
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> getPeriodStats({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      final stats = {
        'totalDetections': 2847,
        'violations': 445,
        'accuracy': 98.7,
        'averagePerDay': 95,
        'peakHour': '14:00',
        'peakHourCount': 180,
      };

      return ApiResponse.success(stats);
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<ApiResponse<Map<String, int>>> getTimeDistribution() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final distribution = {
        'morning': 432,
        'afternoon': 1245,
        'evening': 892,
        'night': 278,
      };

      return ApiResponse.success(distribution);
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }
}
