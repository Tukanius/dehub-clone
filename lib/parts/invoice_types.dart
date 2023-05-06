part of "../models/invoice_types.dart";

InvoiceTypes _$InvoiceTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return InvoiceTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$InvoiceTypesToJson(InvoiceTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
