import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  String get appName => dotenv.env['APP_NAME'] ?? 'Smart Mobile LPR';
  String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';
  String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.example.com';
  String get apiKey => dotenv.env['API_KEY'] ?? '';

  bool get enableCamera => dotenv.env['ENABLE_CAMERA']?.toLowerCase() == 'true';
  bool get enableDebugMode =>
      dotenv.env['ENABLE_DEBUG_MODE']?.toLowerCase() == 'true';
}
