part of '../models/business.dart';

BusinessStaffs _$BusinessStaffsFromJson(Map<String, dynamic> json) {
  return BusinessStaffs(
    id: json['id'] != null ? json['id'] as String : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    userStatus:
        json['userStatus'] != null ? json['userStatus'] as String : null,
  );
}

Map<String, dynamic> _$BusinessStaffsToJson(BusinessStaffs instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['id'] = instance.id;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.userStatus != null) json['userStatus'] = instance.userStatus;

  return json;
}
