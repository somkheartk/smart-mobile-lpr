import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // Singleton pattern
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  // App Configuration
  String get appName => dotenv.env['APP_NAME'] ?? 'Smart Mobile LPR';
  String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';
  String get appEnv => dotenv.env['APP_ENV'] ?? 'development';

  // API Configuration
  String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.example.com';
  int get apiTimeout =>
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;
  String get apiKey => dotenv.env['API_KEY'] ?? '';

  // Authentication
  String get authTokenKey => dotenv.env['AUTH_TOKEN_KEY'] ?? 'lpr_auth_token';
  int get sessionTimeout =>
      int.tryParse(dotenv.env['SESSION_TIMEOUT'] ?? '3600') ?? 3600;

  // Database
  String get dbName => dotenv.env['DB_NAME'] ?? 'lpr_database';
  int get dbVersion => int.tryParse(dotenv.env['DB_VERSION'] ?? '1') ?? 1;

  // Camera Settings
  String get cameraQuality => dotenv.env['CAMERA_QUALITY'] ?? 'high';
  String get cameraFlashMode => dotenv.env['CAMERA_FLASH_MODE'] ?? 'auto';

  // Detection Settings
  double get detectionConfidenceThreshold {
    return double.tryParse(
          dotenv.env['DETECTION_CONFIDENCE_THRESHOLD'] ?? '0.85',
        ) ??
        0.85;
  }

  int get maxDetectionAttempts {
    return int.tryParse(dotenv.env['MAX_DETECTION_ATTEMPTS'] ?? '3') ?? 3;
  }

  // Storage
  String get storagePath => dotenv.env['STORAGE_PATH'] ?? '/storage/lpr';
  int get maxImageSize =>
      int.tryParse(dotenv.env['MAX_IMAGE_SIZE'] ?? '5242880') ?? 5242880;

  // Feature Flags
  bool get enableCamera => dotenv.env['ENABLE_CAMERA']?.toLowerCase() == 'true';
  bool get enableAnalytics =>
      dotenv.env['ENABLE_ANALYTICS']?.toLowerCase() == 'true';
  bool get enableExport => dotenv.env['ENABLE_EXPORT']?.toLowerCase() == 'true';
  bool get enableDebugMode =>
      dotenv.env['ENABLE_DEBUG_MODE']?.toLowerCase() == 'true';

  // Third Party Services
  String get firebaseApiKey => dotenv.env['FIREBASE_API_KEY'] ?? '';
  String get firebaseProjectId => dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  String get firebaseAppId => dotenv.env['FIREBASE_APP_ID'] ?? '';

  // Logging
  String get logLevel => dotenv.env['LOG_LEVEL'] ?? 'info';
  bool get enableCrashReporting =>
      dotenv.env['ENABLE_CRASH_REPORTING']?.toLowerCase() == 'true';

  // Helper methods
  bool get isProduction => appEnv == 'production';
  bool get isDevelopment => appEnv == 'development';
  bool get isStaging => appEnv == 'staging';

  // Print configuration (for debugging)
  void printConfig() {
    if (enableDebugMode) {
      print('=== App Configuration ===');
      print('App Name: $appName');
      print('Version: $appVersion');
      print('Environment: $appEnv');
      print('API Base URL: $apiBaseUrl');
      print('========================');
    }
  }
}
