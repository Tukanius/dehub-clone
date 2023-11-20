part of "../models/invoice_over_due_status.dart";

InvoiceOverdueStatus _$InvoiceOverdueStatusFromJson(Map<String, dynamic> json) {
  return InvoiceOverdueStatus(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    color: json['color'] != null ? json['color'] as String : null,
  );
}

Map<String, dynamic> _$InvoiceOverdueStatusToJson(
    InvoiceOverdueStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.color != null) json['color'] = instance.color;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
