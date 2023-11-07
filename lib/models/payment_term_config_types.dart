part '../parts/payment_term_config_types.dart';

class PaymentTermConfigTypes {
  String? code;
  String? condition;
  String? text;

  PaymentTermConfigTypes({
    this.code,
    this.text,
    this.condition,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$PaymentTermConfigTypesFromJson(json);
  factory PaymentTermConfigTypes.fromJson(Map<String, dynamic> json) =>
      _$PaymentTermConfigTypesFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentTermConfigTypesToJson(this);
}
