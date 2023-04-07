part of '../models/business.dart';

BusinessStaffs _$BusinessStaffsFromJson(Map<String, dynamic> json) {
  String? id;
  String? avatar;
  String? lastName;
  String? firstName;
  String? phone;
  String? email;
  String? userStatus;

  if (json['id'] != null) id = json['id'];
  if (json['avatar'] != null) avatar = json['avatar'];
  if (json['lastName'] != null) lastName = json['lastName'];
  if (json['firstName'] != null) firstName = json['firstName'];
  if (json['phone'] != null) phone = json['phone'];
  if (json['email'] != null) email = json['email'];
  if (json['userStatus'] != null) userStatus = json['userStatus'];

  return BusinessStaffs(
    id: id,
    avatar: avatar,
    lastName: lastName,
    firstName: firstName,
    phone: phone,
    email: email,
    userStatus: userStatus,
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
