part of '../models/bank_accounts.dart';

BankAccounts _$BankAccountsFromJson(Map<String, dynamic> json) {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? businessId;
  String? bankName;
  String? number;
  String? name;
  String? shortName;
  String? currency;
  bool? isDefault;
  bool? isVerified;
  bool? isActive;
  String? icon;

  if (json['id'] != null) id = json['id'];
  if (json['createdAt'] != null) createdAt = json['createdAt'];
  if (json['updatedAt'] != null) updatedAt = json['updatedAt'];
  if (json['deletedAt'] != null) deletedAt = json['deletedAt'];
  if (json['businessId'] != null) businessId = json['businessId'];
  if (json['bankName'] != null) bankName = json['bankName'];
  if (json['number'] != null) number = json['number'];
  if (json['name'] != null) name = json['name'];
  if (json['shortName'] != null) shortName = json['shortName'];
  if (json['currency'] != null) currency = json['currency'];
  if (json['isDefault'] != null) isDefault = json['isDefault'];
  if (json['isVerified'] != null) isVerified = json['isVerified'];
  if (json['isActive'] != null) isActive = json['isActive'];
  if (json['icon'] != null) icon = json['icon'];

  return BankAccounts(
    id: id,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    businessId: businessId,
    bankName: bankName,
    number: number,
    name: name,
    shortName: shortName,
    currency: currency,
    isDefault: isDefault,
    isVerified: isVerified,
    isActive: isActive,
    icon: icon,
  );
}

Map<String, dynamic> _$BankAccountsToJson(BankAccounts instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.bankName != null) json['bankName'] = instance.bankName;
  if (instance.number != null) json['number'] = instance.number;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.shortName != null) json['shortName'] = instance.shortName;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.isDefault != null) json['isDefault'] = instance.isDefault;
  if (instance.isVerified != null) json['isVerified'] = instance.isVerified;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.icon != null) json['icon'] = instance.icon;

  return json;
}
