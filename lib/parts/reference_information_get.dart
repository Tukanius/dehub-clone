part of '../models/reference_information_get.dart';

ReferenceInformationGet _$ReferenceInformationGetFromJson(
    Map<String, dynamic> json) {
  return ReferenceInformationGet(
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    modifiedUserId: json['modifiedUserId'] != null
        ? json['modifiedUserId'] as String
        : null,
    termRule: json['termRule'] != null ? json['termRule'] as String : null,
    orderConfirmTerm: json['orderConfirmTerm'] != null
        ? json['orderConfirmTerm'] as String
        : null,
    expireDayCount: json['expireDayCount'] != null
        ? int.parse(json['expireDayCount'].toString())
        : null,
    month: json['month'] != null ? int.parse(json['month'].toString()) : null,
    paymentDay:
        json['paymentDay'] != null ? json['paymentDay'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    isMain: json['isMain'] != null ? json['isMain'] as bool : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    isOpen: json['isOpen'] != null ? json['isOpen'] as bool : null,
    modifiedUser: json['modifiedUser'] != null
        ? ReferenceInformationGet.fromJson(
            json['modifiedUser'] as Map<String, dynamic>)
        : null,
    sessionId: json['sessionId'] != null ? json['sessionId'] as String : null,
    username: json['username'] != null ? json['username'] as String : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    currentBusinessId: json['currentBusinessId'] != null
        ? json['currentBusinessId'] as String
        : null,
    employeeUnitId: json['employeeUnitId'] != null
        ? json['employeeUnitId'] as String
        : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    userStatus:
        json['userStatus'] != null ? json['userStatus'] as String : null,
    registerStatus: json['registerStatus'] != null
        ? json['registerStatus'] as String
        : null,
    loginType: json['loginType'] != null ? json['loginType'] as String : null,
    isSysUser: json['isSysUser'] != null ? json['isSysUser'] as bool : null,
    isAppUser: json['isAppUser'] != null ? json['isAppUser'] as bool : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    regUserId: json['regUserId'] != null ? json['regUserId'] as String : null,
    parentId: json['parentId'] != null ? json['parentId'] as String : null,
    isParent: json['isParent'] != null ? json['isParent'] as bool : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$ReferenceInformationGetToJson(
    ReferenceInformationGet instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.modifiedUserId != null)
    json['modifiedUserId'] = instance.modifiedUserId;
  if (instance.termRule != null) json['termRule'] = instance.termRule;
  if (instance.orderConfirmTerm != null)
    json['orderConfirmTerm'] = instance.orderConfirmTerm;
  if (instance.expireDayCount != null)
    json['expireDayCount'] = instance.expireDayCount;
  if (instance.month != null) json['month'] = instance.month;
  if (instance.paymentDay != null) json['paymentDay'] = instance.paymentDay;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.isMain != null) json['isMain'] = instance.isMain;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.isOpen != null) json['isOpen'] = instance.isOpen;
  if (instance.modifiedUser != null)
    json['modifiedUser'] = instance.modifiedUser;
  if (instance.sessionId != null) json['sessionId'] = instance.sessionId;
  if (instance.username != null) json['username'] = instance.username;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.currentBusinessId != null)
    json['currentBusinessId'] = instance.currentBusinessId;
  if (instance.employeeUnitId != null)
    json['employeeUnitId'] = instance.employeeUnitId;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.userStatus != null) json['userStatus'] = instance.userStatus;
  if (instance.registerStatus != null)
    json['registerStatus'] = instance.registerStatus;
  if (instance.loginType != null) json['loginType'] = instance.loginType;
  if (instance.isSysUser != null) json['isSysUser'] = instance.isSysUser;
  if (instance.isAppUser != null) json['isAppUser'] = instance.isAppUser;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.parentId != null) json['parentId'] = instance.parentId;
  if (instance.isParent != null) json['isParent'] = instance.isParent;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
