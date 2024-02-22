part '../parts/system_usage_type.dart';

class SystemUsageType {
  String? code;
  String? name;

  SystemUsageType({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$SystemUsageTypeFromJson(json);
  factory SystemUsageType.fromJson(Map<String, dynamic> json) =>
      _$SystemUsageTypeFromJson(json);
  Map<String, dynamic> toJson() => _$SystemUsageTypeToJson(this);
}
