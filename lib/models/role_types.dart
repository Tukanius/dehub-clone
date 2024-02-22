part '../parts/role_types.dart';

class RoleTypes {
  String? code;
  String? name;

  RoleTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$RoleTypesFromJson(json);
  factory RoleTypes.fromJson(Map<String, dynamic> json) =>
      _$RoleTypesFromJson(json);
  Map<String, dynamic> toJson() => _$RoleTypesToJson(this);
}
