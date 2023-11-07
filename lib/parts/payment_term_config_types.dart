part of "../models/payment_term_config_types.dart";

PaymentTermConfigTypes _$PaymentTermConfigTypesFromJson(
    Map<String, dynamic> json) {
  return PaymentTermConfigTypes(
    code: json['code'] != null ? json['code'] as String : null,
    condition: json['condition'] != null ? json['condition'] as String : null,
    text: json['text'] != null ? json['text'] as String : null,
  );
}

Map<String, dynamic> _$PaymentTermConfigTypesToJson(
    PaymentTermConfigTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.condition != null) json['condition'] = instance.condition;
  if (instance.text != null) json['text'] = instance.text;

  return json;
}
