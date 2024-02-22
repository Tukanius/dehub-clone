part '../parts/role_status.dart';

class RoleStatus {
  String? code;
  String? name;
  String? color;

  RoleStatus({
    this.color,
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$RoleStatusFromJson(json);
  factory RoleStatus.fromJson(Map<String, dynamic> json) =>
      _$RoleStatusFromJson(json);
  Map<String, dynamic> toJson() => _$RoleStatusToJson(this);
}
