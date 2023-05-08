part of '../models/branch_status.dart';

BranchStatus _$BranchStatusFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return BranchStatus(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$BranchStatusToJson(BranchStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
