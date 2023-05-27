part of '../models/permissions.dart';

Permissions _$PermissionsFromJson(Map<String, dynamic> json) {
  return Permissions(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    module: json['module'] != null ? json['module'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    isView: json['isView'] != null ? json['isView'] as bool : null,
    isCreate: json['isCreate'] != null ? json['isCreate'] as bool : null,
    isEdit: json['isEdit'] != null ? json['isEdit'] as bool : null,
    isReview: json['isReview'] != null ? json['isReview'] as bool : null,
    isDelete: json['isDelete'] != null ? json['isDelete'] as bool : null,
  );
}

Map<String, dynamic> _$PermissionsToJson(Permissions instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.module != null) json['module'] = instance.module;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.isView != null) json['isView'] = instance.isView;
  if (instance.isCreate != null) json['isCreate'] = instance.isCreate;
  if (instance.isEdit != null) json['isEdit'] = instance.isEdit;
  if (instance.isReview != null) json['isReview'] = instance.isReview;
  if (instance.isDelete != null) json['isDelete'] = instance.isDelete;

  return json;
}
