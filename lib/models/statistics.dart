class DashboardStats {
  final int totalVehicles;
  final int todayCount;
  final int monthCount;
  final double accuracy;

  DashboardStats({
    required this.totalVehicles,
    required this.todayCount,
    required this.monthCount,
    required this.accuracy,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalVehicles: json['totalVehicles'] as int,
      todayCount: json['todayCount'] as int,
      monthCount: json['monthCount'] as int,
      accuracy: (json['accuracy'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalVehicles': totalVehicles,
      'todayCount': todayCount,
      'monthCount': monthCount,
      'accuracy': accuracy,
    };
  }
}

class ViolationStats {
  final String type;
  final int count;
  final double percentage;

  ViolationStats({
    required this.type,
    required this.count,
    required this.percentage,
  });

  factory ViolationStats.fromJson(Map<String, dynamic> json) {
    return ViolationStats(
      type: json['type'] as String,
      count: json['count'] as int,
      percentage: (json['percentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'count': count, 'percentage': percentage};
  }
}

class DetectionData {
  final String time;
  final int count;

  DetectionData({required this.time, required this.count});

  factory DetectionData.fromJson(Map<String, dynamic> json) {
    return DetectionData(
      time: json['time'] as String,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'time': time, 'count': count};
  }
}

class MonthlyStats {
  final String month;
  final int count;

  MonthlyStats({required this.month, required this.count});

  factory MonthlyStats.fromJson(Map<String, dynamic> json) {
    return MonthlyStats(
      month: json['month'] as String,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'month': month, 'count': count};
  }
}
