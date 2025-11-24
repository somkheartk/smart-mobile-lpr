import '../models/operator.dart';
import '../models/api_response.dart';

class OperatorService {
  static final OperatorService _instance = OperatorService._internal();
  factory OperatorService() => _instance;
  OperatorService._internal();

  Future<ApiResponse<List<Operator>>> getTopOperators({int limit = 10}) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final operators = [
        Operator(
          id: 'op1',
          name: 'การเอาตามรถทวงทางเมืองท่า',
          email: 'operator1@lpr.com',
          detectionCount: 487,
          accuracy: 95.2,
          rank: 2,
        ),
        Operator(
          id: 'op2',
          name: 'ผังถนนกระชับธุรกิจ',
          email: 'operator2@lpr.com',
          detectionCount: 352,
          accuracy: 96.8,
          rank: 5,
        ),
        Operator(
          id: 'op3',
          name: 'ผังถนนกระชับธุรกิจ',
          email: 'operator3@lpr.com',
          detectionCount: 125,
          accuracy: 87.3,
          rank: 18,
        ),
      ];

      return ApiResponse.success(operators.take(limit).toList());
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<ApiResponse<Operator>> getOperatorById(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 400));

      final operator = Operator(
        id: id,
        name: 'การเอาตามรถทวงทางเมืองท่า',
        email: 'operator@lpr.com',
        detectionCount: 487,
        accuracy: 95.2,
        rank: 2,
      );

      return ApiResponse.success(operator);
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<Operator>>> getAllOperators() async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      final operators = List.generate(
        20,
        (index) => Operator(
          id: 'op_$index',
          name: 'ผู้ปฏิบัติงาน ${index + 1}',
          email: 'operator$index@lpr.com',
          detectionCount: 500 - (index * 20),
          accuracy: 90.0 + (index % 10),
          rank: index + 1,
        ),
      );

      return ApiResponse.success(operators);
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }
}
