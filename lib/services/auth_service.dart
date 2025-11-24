import '../models/user.dart';
import '../models/api_response.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;
  String? _token;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null && _token != null;

  Future<ApiResponse<User>> login(String username, String password) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock user data
      if (username.isNotEmpty && password.isNotEmpty) {
        final user = User(
          id: '1',
          username: username,
          email: 'admin@lpr.com',
          fullName: 'ผู้ดูแลระบบ',
          role: UserRole.admin,
          createdAt: DateTime.now(),
          lastLoginAt: DateTime.now(),
        );

        _currentUser = user;
        _token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';

        return ApiResponse.success(user, message: 'เข้าสู่ระบบสำเร็จ');
      }

      return ApiResponse.error('ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง');
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _token = null;
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<ApiResponse<User>> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: username,
        email: email,
        fullName: fullName,
        role: UserRole.operator,
        createdAt: DateTime.now(),
      );

      return ApiResponse.success(user, message: 'ลงทะเบียนสำเร็จ');
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<ApiResponse<bool>> resetPassword(String email) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return ApiResponse.success(
        true,
        message: 'ส่งลิงก์รีเซ็ตรหัสผ่านไปยังอีเมลแล้ว',
      );
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  Future<ApiResponse<User>> updateProfile({
    String? fullName,
    String? email,
    String? avatarUrl,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (_currentUser == null) {
        return ApiResponse.error('กรุณาเข้าสู่ระบบ');
      }

      final updatedUser = User(
        id: _currentUser!.id,
        username: _currentUser!.username,
        email: email ?? _currentUser!.email,
        fullName: fullName ?? _currentUser!.fullName,
        role: _currentUser!.role,
        avatarUrl: avatarUrl ?? _currentUser!.avatarUrl,
        createdAt: _currentUser!.createdAt,
        lastLoginAt: DateTime.now(),
      );

      _currentUser = updatedUser;

      return ApiResponse.success(updatedUser, message: 'อัปเดตข้อมูลสำเร็จ');
    } catch (e) {
      return ApiResponse.error('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }
}
