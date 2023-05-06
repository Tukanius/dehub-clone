part of "../models/transaction_types.dart";

TransactionTypes _$TransactionTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return TransactionTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$TransactionTypesToJson(TransactionTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
