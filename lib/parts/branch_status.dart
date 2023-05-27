part of '../models/branch_status.dart';

BranchStatus _$BranchStatusFromJson(Map<String, dynamic> json) {
  return BranchStatus(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$BranchStatusToJson(BranchStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
