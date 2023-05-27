part of '../models/staffs.dart';

Staffs _$StaffsFromJson(Map<String, dynamic> json) {
  return Staffs(
    id: json['id'] != null ? json['id'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
  );
}

Map<String, dynamic> _$StaffsToJson(Staffs instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['id'] = instance.id;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.avatar != null) json['avatar'] = instance.avatar;

  return json;
}
