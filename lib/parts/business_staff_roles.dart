part of '../models/business_staff_roles.dart';

BusinessStaffRoles _$BusinessStaffRolesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return BusinessStaffRoles(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$BusinessStaffRolesToJson(BusinessStaffRoles instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
