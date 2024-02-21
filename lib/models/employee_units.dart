part '../parts/employee_units.dart';

class EmployeeUnits {
  String id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? departmentUnitId;
  String? name;

  EmployeeUnits({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.departmentUnitId,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$EmployeeUnitsFromJson(json);

  factory EmployeeUnits.fromJson(Map<String, dynamic> json) =>
      _$EmployeeUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeUnitsToJson(this);
}
