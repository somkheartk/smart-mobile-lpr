class Vehicle {
  final String id;
  final String plateNumber;
  final VehicleType type;
  final String location;
  final DateTime detectedAt;
  final bool isViolation;
  final String? violationType;
  final String? imageUrl;
  final double confidence;
  final String? province;
  final int? speed;
  final String cameraId;
  final String? direction;

  Vehicle({
    required this.id,
    required this.plateNumber,
    required this.type,
    required this.location,
    required this.detectedAt,
    required this.isViolation,
    this.violationType,
    this.imageUrl,
    this.confidence = 0.95,
    this.province,
    this.speed,
    required this.cameraId,
    this.direction,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as String,
      plateNumber: json['plateNumber'] as String,
      type: VehicleType.fromString(json['type'] as String),
      location: json['location'] as String,
      detectedAt: DateTime.parse(json['detectedAt'] as String),
      isViolation: json['isViolation'] as bool,
      violationType: json['violationType'] as String?,
      imageUrl: json['imageUrl'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.95,
      province: json['province'] as String?,
      speed: json['speed'] as int?,
      cameraId: json['cameraId'] as String? ?? 'unknown',
      direction: json['direction'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plateNumber': plateNumber,
      'type': type.value,
      'location': location,
      'detectedAt': detectedAt.toIso8601String(),
      'isViolation': isViolation,
      'violationType': violationType,
      'imageUrl': imageUrl,
      'confidence': confidence,
      'province': province,
      'speed': speed,
      'cameraId': cameraId,
      'direction': direction,
    };
  }

  Vehicle copyWith({
    String? id,
    String? plateNumber,
    VehicleType? type,
    String? location,
    DateTime? detectedAt,
    bool? isViolation,
    String? violationType,
    String? imageUrl,
    double? confidence,
    String? province,
    int? speed,
    String? cameraId,
    String? direction,
  }) {
    return Vehicle(
      id: id ?? this.id,
      plateNumber: plateNumber ?? this.plateNumber,
      type: type ?? this.type,
      location: location ?? this.location,
      detectedAt: detectedAt ?? this.detectedAt,
      isViolation: isViolation ?? this.isViolation,
      violationType: violationType ?? this.violationType,
      imageUrl: imageUrl ?? this.imageUrl,
      confidence: confidence ?? this.confidence,
      province: province ?? this.province,
      speed: speed ?? this.speed,
      cameraId: cameraId ?? this.cameraId,
      direction: direction ?? this.direction,
    );
  }
}

enum VehicleType {
  car('รถเก๋ง'),
  truck('รถบรรทุก'),
  van('รถตู้'),
  pickup('รถกระบะ'),
  motorcycle('รถจักรยานยนต์');

  final String value;
  const VehicleType(this.value);

  static VehicleType fromString(String value) {
    switch (value) {
      case 'รถเก๋ง':
        return VehicleType.car;
      case 'รถบรรทุก':
        return VehicleType.truck;
      case 'รถตู้':
        return VehicleType.van;
      case 'รถกระบะ':
        return VehicleType.pickup;
      case 'รถจักรยานยนต์':
        return VehicleType.motorcycle;
      default:
        return VehicleType.car;
    }
  }
}
