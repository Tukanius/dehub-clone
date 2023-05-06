part of "../models/invoice_payment_status.dart";

InvoicePaymentStatus _$InvoicePaymentStatusFromJson(Map<String, dynamic> json) {
  String? code;
  String? color;
  String? name;

  if (json['color'] != null) color = json['color'];
  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return InvoicePaymentStatus(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$InvoicePaymentStatusToJson(
    InvoicePaymentStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.color != null) json['color'] = instance.color;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
