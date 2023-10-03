part of '../models/payment.dart';

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment(
    count: json['count'] != null ? int.parse(json['count'].toString()) : null,
    rows: json['rows'] != null
        ? (json['rows'] as List).map((e) => Payment.fromJson(e)).toList()
        : null,
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    regUserId: json['regUserId'] != null ? json['regUserId'] as String : null,
    bankName: json['bankName'] != null ? json['bankName'] as String : null,
    number: json['number'] != null ? json['number'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    shortName: json['shortName'] != null ? json['shortName'] as String : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
    isDefault: json['isDefault'] != null ? json['isDefault'] as bool : null,
    isVerified: json['isVerified'] != null ? json['isVerified'] as bool : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    icon: json['icon'] != null ? json['icon'] as String : null,
    business: json['business'] != null
        ? Payment.fromJson(json['business'] as Map<String, dynamic>)
        : null,
    regNumber: json['regNumber'] != null ? json['regNumber'] as String : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    profileName:
        json['profileName'] != null ? json['profileName'] as String : null,
    partner: json['partner'] != null
        ? Payment.fromJson(json['partner'] as Map<String, dynamic>)
        : null,
    businessName:
        json['businessName'] != null ? json['businessName'] as String : null,
    regUser: json['regUser'] != null
        ? Payment.fromJson(json['regUser'] as Map<String, dynamic>)
        : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
  );
}

Map<String, dynamic> _$PaymentToJson(Payment instance) {
  Map<String, dynamic> json = {};

  if (instance.count != null) json['count'] = instance.count;
  if (instance.rows != null) json['rows'] = instance.rows;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.bankName != null) json['bankName'] = instance.bankName;
  if (instance.number != null) json['number'] = instance.number;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.shortName != null) json['shortName'] = instance.shortName;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.isDefault != null) json['isDefault'] = instance.isDefault;
  if (instance.isVerified != null) json['isVerified'] = instance.isVerified;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.icon != null) json['icon'] = instance.icon;
  if (instance.business != null) json['business'] = instance.business;
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.businessName != null)
    json['businessName'] = instance.businessName;
  if (instance.regUser != null) json['regUser'] = instance.regUser;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.lastName != null) json['lastName'] = instance.lastName;

  return json;
}
