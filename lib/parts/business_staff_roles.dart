part of '../models/business_staff_roles.dart';

BusinessStaffRoles _$BusinessStaffRolesFromJson(Map<String, dynamic> json) {
  return BusinessStaffRoles(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$BusinessStaffRolesToJson(BusinessStaffRoles instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
