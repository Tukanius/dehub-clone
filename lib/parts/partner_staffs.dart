part of '../models/partner_staffs.dart';

PartnerStaffs _$PartnerStaffsFromJson(Map<String, dynamic> json) {
  return PartnerStaffs(
    id: json['id'] != null ? json['id'] as String : null,
    registerNo:
        json['registerNo'] != null ? json['registerNo'] as String : null,
    familyName:
        json['familyName'] != null ? json['familyName'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
  );
}

Map<String, dynamic> _$PartnerStaffsToJson(PartnerStaffs instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['id'] = instance.id;
  if (instance.registerNo != null) json['registerNo'] = instance.registerNo;
  if (instance.familyName != null) json['familyName'] = instance.familyName;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.avatar != null) json['avatar'] = instance.avatar;

  return json;
}
