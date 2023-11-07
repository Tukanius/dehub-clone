part of "../models/payment_term_conditions.dart";

PaymentTermConditions _$PaymentTermConditionsFromJson(
    Map<String, dynamic> json) {
  return PaymentTermConditions(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$PaymentTermConditionsToJson(
    PaymentTermConditions instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
