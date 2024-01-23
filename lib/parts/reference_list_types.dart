part of '../models/reference_list_types.dart';

ReferenceListTypes _$ReferenceListTypesFromJson(Map<String, dynamic> json) {
  return ReferenceListTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    COD: json['COD'] != null
        ? ReferenceListTypes.fromJson(json['COD'] as Map<String, dynamic>)
        : null,
    INV_NET2: json['INV_NET2'] != null
        ? ReferenceListTypes.fromJson(json['INV_NET2'] as Map<String, dynamic>)
        : null,
    AR_NET30: json['AR_NET30'] != null
        ? ReferenceListTypes.fromJson(json['AR_NET30'] as Map<String, dynamic>)
        : null,
    REGION: json['REGION'] != null
        ? ReferenceListTypes.fromJson(json['REGION'] as Map<String, dynamic>)
        : null,
    DIRECTION: json['DIRECTION'] != null
        ? ReferenceListTypes.fromJson(json['DIRECTION'] as Map<String, dynamic>)
        : null,
    CLIENT_CATEGORY: json['CLIENT_CATEGORY'] != null
        ? ReferenceListTypes.fromJson(
            json['CLIENT_CATEGORY'] as Map<String, dynamic>)
        : null,
    CLIENT_PRIORITY: json['CLIENT_PRIORITY'] != null
        ? ReferenceListTypes.fromJson(
            json['CLIENT_PRIORITY'] as Map<String, dynamic>)
        : null,
  );
}

Map<String, dynamic> _$ReferenceListTypesToJson(ReferenceListTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.COD != null) json['COD'] = instance.COD;
  if (instance.INV_NET2 != null) json['INV_NET2'] = instance.INV_NET2;
  if (instance.AR_NET30 != null) json['AR_NET30'] = instance.AR_NET30;
  if (instance.REGION != null) json['REGION'] = instance.REGION;
  if (instance.DIRECTION != null) json['DIRECTION'] = instance.DIRECTION;
  if (instance.CLIENT_CATEGORY != null) {
    json['CLIENT_CATEGORY'] = instance.CLIENT_CATEGORY;
  }
  if (instance.CLIENT_PRIORITY != null) {
    json['CLIENT_PRIORITY'] = instance.CLIENT_PRIORITY;
  }

  return json;
}
