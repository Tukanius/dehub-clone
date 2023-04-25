part of "../models/invoice_history_types.dart";

InvoiceHistoryTypes _$InvoiceHistoryTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json[code] != null) code = json['code'];
  if (json[name] != null) name = json['name'];

  return InvoiceHistoryTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$InvoiceHistoryTypesToJson(InvoiceHistoryTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
