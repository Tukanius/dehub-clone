part of "../models/payment_term_rules.dart";

PaymentTermRules _$PaymentTermRulesFromJson(Map<String, dynamic> json) {
  String? code;
  String? text;

  if (json[code] != null) code = json['code'];
  if (json[text] != null) text = json['text'];

  return PaymentTermRules(
    code: code,
    text: text,
  );
}

Map<String, dynamic> _$PaymentTermRulesToJson(PaymentTermRules instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.text != null) json['text'] = instance.text;

  return json;
}
