import 'dart:convert';

class Config {
  String endpoint;
  String projectId;
  String devKey;

  Config({
    required this.endpoint,
    required this.projectId,
    required this.devKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'endpoint': endpoint,
      'projectId': projectId,
      'devKey': devKey,
    };
  }

  factory Config.fromMap(Map<String, dynamic> map) {
    return Config(
      endpoint: map['endpoint'] ?? '',
      projectId: map['projectId'] ?? '',
      devKey: map['devKey'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Config.fromJson(String source) => Config.fromMap(json.decode(source));
}
