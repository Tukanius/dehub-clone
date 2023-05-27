part of "../models/invoice_history_types.dart";

InvoiceHistoryTypes _$InvoiceHistoryTypesFromJson(Map<String, dynamic> json) {
  return InvoiceHistoryTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$InvoiceHistoryTypesToJson(InvoiceHistoryTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
