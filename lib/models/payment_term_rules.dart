part '../parts/payment_term_rules.dart';

class PaymentTermRules {
  String? code;
  String? text;

  PaymentTermRules({
    this.code,
    this.text,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$PaymentTermRulesFromJson(json);
  factory PaymentTermRules.fromJson(Map<String, dynamic> json) =>
      _$PaymentTermRulesFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentTermRulesToJson(this);
}
