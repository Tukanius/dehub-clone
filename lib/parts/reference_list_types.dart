part of '../models/reference_list_types.dart';

ReferenceListTypes _$ReferenceListTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;
  ReferenceListTypes? COD;
  ReferenceListTypes? INV_NET2;
  ReferenceListTypes? AR_NET30;
  ReferenceListTypes? REGION;
  ReferenceListTypes? DIRECTION;
  ReferenceListTypes? CLIENT_CATEGORY;
  ReferenceListTypes? CLIENT_PRIORITY;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];
  if (json['COD'] != null) {
    COD = ReferenceListTypes.fromJson(json['COD'] as Map<String, dynamic>);
  }
  if (json['INV_NET2'] != null) {
    INV_NET2 =
        ReferenceListTypes.fromJson(json['INV_NET2'] as Map<String, dynamic>);
  }
  if (json['INV_NET2'] != null) {
    COD = ReferenceListTypes.fromJson(json['COD'] as Map<String, dynamic>);
  }
  if (json['AR_NET30'] != null) {
    AR_NET30 =
        ReferenceListTypes.fromJson(json['AR_NET30'] as Map<String, dynamic>);
  }
  if (json['REGION'] != null) {
    REGION =
        ReferenceListTypes.fromJson(json['REGION'] as Map<String, dynamic>);
  }
  if (json['DIRECTION'] != null) {
    DIRECTION =
        ReferenceListTypes.fromJson(json['DIRECTION'] as Map<String, dynamic>);
  }
  if (json['CLIENT_CATEGORY'] != null) {
    CLIENT_CATEGORY = ReferenceListTypes.fromJson(
        json['CLIENT_CATEGORY'] as Map<String, dynamic>);
  }
  if (json['CLIENT_PRIORITY'] != null) {
    CLIENT_PRIORITY = ReferenceListTypes.fromJson(
        json['CLIENT_PRIORITY'] as Map<String, dynamic>);
  }
  return ReferenceListTypes(
    code: code,
    name: name,
    COD: COD,
    INV_NET2: INV_NET2,
    AR_NET30: AR_NET30,
    REGION: REGION,
    DIRECTION: DIRECTION,
    CLIENT_CATEGORY: CLIENT_CATEGORY,
    CLIENT_PRIORITY: CLIENT_PRIORITY,
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
  if (instance.CLIENT_CATEGORY != null)
    json['CLIENT_CATEGORY'] = instance.CLIENT_CATEGORY;
  if (instance.CLIENT_PRIORITY != null)
    json['CLIENT_PRIORITY'] = instance.CLIENT_PRIORITY;

  return json;
}
