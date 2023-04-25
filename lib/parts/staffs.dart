part of '../models/staffs.dart';

Staffs _$StaffsFromJson(Map<String, dynamic> json) {
  String? id;
  String? lastName;
  String? firstName;
  String? avatar;

  if (json[id] != null) id = json['id'];
  if (json[lastName] != null) lastName = json['lastName'];
  if (json[firstName] != null) firstName = json['firstName'];
  if (json[avatar] != null) avatar = json['avatar'];

  return Staffs(
    id: id,
    lastName: lastName,
    firstName: firstName,
    avatar: avatar,
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
