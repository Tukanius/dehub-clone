part of '../models/bank_names.dart';

BankNames _$BankNamesFromJson(Map<String, dynamic> json) {
  return BankNames(
    code: json['code'] != null ? json['code'] as String : null,
    bankCode: json['bankCode'] != null ? json['bankCode'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    icon: json['icon'] != null ? json['icon'] as String : null,
  );
}

Map<String, dynamic> _$BankNamesToJson(BankNames instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.bankCode != null) json['bankCode'] = instance.bankCode;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.icon != null) json['icon'] = instance.icon;

  return json;
}
