part of '../models/permissions.dart';

Permissions _$PermissionsFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  String? module;
  String? description;
  bool? isView;
  bool? isCreate;
  bool? isEdit;
  bool? isReview;
  bool? isDelete;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];
  if (json['module'] != null) module = json['module'];
  if (json['description'] != null) description = json['description'];
  if (json['isView'] != null) isView = json['isView'];
  if (json['isCreate'] != null) isCreate = json['isCreate'];
  if (json['isEdit'] != null) isEdit = json['isEdit'];
  if (json['isReview'] != null) isReview = json['isReview'];
  if (json['isDelete'] != null) isDelete = json['isDelete'];

  return Permissions(
    code: code,
    name: name,
    module: module,
    description: description,
    isView: isView,
    isCreate: isCreate,
    isEdit: isEdit,
    isReview: isReview,
    isDelete: isDelete,
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
