part of "../models/order_confirm_terms.dart";

OrderConfirmTerms _$OrderConfirmTermsFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json[code] != null) code = json['code'];
  if (json[name] != null) name = json['name'];

  return OrderConfirmTerms(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$OrderConfirmTermsToJson(OrderConfirmTerms instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
