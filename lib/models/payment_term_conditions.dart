part '../parts/payment_term_conditions.dart';

class PaymentTermConditions {
  String? code;
  String? name;

  PaymentTermConditions({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$PaymentTermConditionsFromJson(json);
  factory PaymentTermConditions.fromJson(Map<String, dynamic> json) =>
      _$PaymentTermConditionsFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentTermConditionsToJson(this);
}
