part of '../models/user_register_status.dart';

UserRegisterStatus _$UserRegisterStatusFromJson(Map<String, dynamic> json) {
  return UserRegisterStatus(
    code: json['code'] != null ? json['code'] as String : null,
    color: json['color'] != null ? json['color'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$UserRegisterStatusToJson(UserRegisterStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.color != null) json['color'] = instance.color;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
