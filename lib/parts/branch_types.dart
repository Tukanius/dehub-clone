part of '../models/branch_types.dart';

BranchTypes _$BranchTypesFromJson(Map<String, dynamic> json) {
  return BranchTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$BranchTypesToJson(BranchTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
