part '../parts/department_units.dart';

class DepartmentUnits {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? name;
  String? partnerId;
  String? parentId;
  bool? isPublic;

  DepartmentUnits({
    this.partnerId,
    this.parentId,
    this.isPublic,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$DepartmentUnitsFromJson(json);

  factory DepartmentUnits.fromJson(Map<String, dynamic> json) =>
      _$DepartmentUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentUnitsToJson(this);
}
