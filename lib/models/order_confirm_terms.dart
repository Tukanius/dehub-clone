part '../parts/order_confirm_terms.dart';

class OrderConfirmTerms {
  String? code;
  String? name;

  OrderConfirmTerms({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$OrderConfirmTermsFromJson(json);
  factory OrderConfirmTerms.fromJson(Map<String, dynamic> json) =>
      _$OrderConfirmTermsFromJson(json);
  Map<String, dynamic> toJson() => _$OrderConfirmTermsToJson(this);
}
