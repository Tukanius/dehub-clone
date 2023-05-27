part of "../models/order_confirm_terms.dart";

OrderConfirmTerms _$OrderConfirmTermsFromJson(Map<String, dynamic> json) {
  return OrderConfirmTerms(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$OrderConfirmTermsToJson(OrderConfirmTerms instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
