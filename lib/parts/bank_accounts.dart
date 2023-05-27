part of '../models/bank_accounts.dart';

BankAccounts _$BankAccountsFromJson(Map<String, dynamic> json) {
  return BankAccounts(
    id: json['id'] as String,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    bankName: json['bankName'] != null ? json['bankName'] as String : null,
    number: json['number'] != null ? json['number'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    shortName: json['shortName'] != null ? json['shortName'] as String : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
    isDefault: json['isDefault'] != null ? json['isDefault'] as bool : null,
    isVerified: json['isVerified'] != null ? json['isVerified'] as bool : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    icon: json['icon'] != null ? json['icon'] as String : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    regUserId: json['regUserId'] != null ? json['regUserId'] as String : null,
    balance: json['balance'] != null ? json['balance'] as String : null,
  );
}

Map<String, dynamic> _$BankAccountsToJson(BankAccounts instance) {
  Map<String, dynamic> json = {};

  json['id'] = instance.id;
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
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.balance != null) json['balance'] = instance.balance;

  return json;
}
