import 'dart:convert';

enum Plan {
  free,
  pro,
  scale,
}

extension PlanExtension on Plan {
  String get description {
    switch (this) {
      case Plan.free:
        return 'Free Plan: 100 operations per transaction';
      case Plan.pro:
        return 'Pro Plan: 1,000 operations per transaction';
      case Plan.scale:
        return 'Scale Plan: 2,500 operations per transaction';
    }
  }
}

class Config {
  String endpoint;
  String projectId;
  String devKey;
  Plan plan;

  Config({
    required this.endpoint,
    required this.projectId,
    required this.devKey,
    this.plan = Plan.free,
  });

  Map<String, dynamic> toMap() {
    return {
      'endpoint': endpoint,
      'projectId': projectId,
      'devKey': devKey,
      'plan': plan.toString(),
    };
  }

  factory Config.fromMap(Map<String, dynamic> map) {
    return Config(
      endpoint: map['endpoint'] ?? '',
      projectId: map['projectId'] ?? '',
      devKey: map['devKey'] ?? '',
      plan: Plan.values.firstWhere(
        (e) => e.toString() == map['plan'],
        orElse: () => Plan.free,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Config.fromJson(String source) => Config.fromMap(json.decode(source));
}
