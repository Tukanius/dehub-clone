part of "../models/payment_term_rules.dart";

PaymentTermRules _$PaymentTermRulesFromJson(Map<String, dynamic> json) {
  return PaymentTermRules(
    code: json['code'] != null ? json['code'] as String : null,
    text: json['text'] != null ? json['text'] as String : null,
  );
}

Map<String, dynamic> _$PaymentTermRulesToJson(PaymentTermRules instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.text != null) json['text'] = instance.text;

  return json;
}
