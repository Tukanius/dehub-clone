part '../parts/roles.dart';

class Roles {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? name;

  Roles({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$RolesFromJson(json);

  factory Roles.fromJson(Map<String, dynamic> json) => _$RolesFromJson(json);

  Map<String, dynamic> toJson() => _$RolesToJson(this);
}
