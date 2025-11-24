class Operator {
  final String id;
  final String name;
  final String email;
  final int detectionCount;
  final double accuracy;
  final int rank;
  final String? avatarUrl;

  Operator({
    required this.id,
    required this.name,
    required this.email,
    required this.detectionCount,
    required this.accuracy,
    required this.rank,
    this.avatarUrl,
  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      detectionCount: json['detectionCount'] as int,
      accuracy: (json['accuracy'] as num).toDouble(),
      rank: json['rank'] as int,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'detectionCount': detectionCount,
      'accuracy': accuracy,
      'rank': rank,
      'avatarUrl': avatarUrl,
    };
  }

  bool get isTopPerformer => rank <= 3;
}
