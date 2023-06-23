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
    termRule: json['termRule'] != null ? json['termRule'] as String : null,
    orderConfirmTerm: json['orderConfirmTerm'] != null
        ? json['orderConfirmTerm'] as String
        : null,
    expireDayCount: json['expireDayCount'] != null
        ? int.parse(json['expireDayCount'].toString())
        : null,
    month: json['month'] != null ? int.parse(json['month'].toString()) : null,
    paymentDay: json['paymentDay'] != null
        ? int.parse(json['paymentDay'].toString())
        : null,
    name: json['name'] != null ? json['name'] as String : null,
    parentId: json['parentId'] != null ? json['parentId'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
  );
}

Map<String, dynamic> _$BusinessStaffsToJson(BusinessStaffs instance) {
  Map<String, dynamic> json = {};
  if (instance.name != null) json['name'] = instance.name;
  if (instance.parentId != null) json['parentId'] = instance.parentId;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.termRule != null) json['termRule'] = instance.termRule;
  if (instance.orderConfirmTerm != null)
    json['orderConfirmTerm'] = instance.orderConfirmTerm;
  if (instance.expireDayCount != null)
    json['expireDayCount'] = instance.expireDayCount;
  if (instance.month != null) json['month'] = instance.month;
  if (instance.paymentDay != null) json['paymentDay'] = instance.paymentDay;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.userStatus != null) json['userStatus'] = instance.userStatus;

  return json;
}
