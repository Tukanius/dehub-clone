part of "../models/invoice_history_log_types.dart";

InvoiceHistoryLogTypes _$InvoiceHistoryLogTypesFromJson(
    Map<String, dynamic> json) {
  return InvoiceHistoryLogTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$InvoiceHistoryLogTypesToJson(
    InvoiceHistoryLogTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
