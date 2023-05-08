part '../parts/business_staff_roles.dart';

class BusinessStaffRoles {
  String? code;
  String? name;

  BusinessStaffRoles({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$BusinessStaffRolesFromJson(json);
  factory BusinessStaffRoles.fromJson(Map<String, dynamic> json) =>
      _$BusinessStaffRolesFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessStaffRolesToJson(this);
}
