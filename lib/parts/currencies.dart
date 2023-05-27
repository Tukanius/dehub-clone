part of "../models/currencies.dart";

Currencies _$CurrenciesFromJson(Map<String, dynamic> json) {
  return Currencies(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    symbol: json['symbol'] != null ? json['symbol'] as String : null,
  );
}

Map<String, dynamic> _$CurrenciesToJson(Currencies instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.symbol != null) json['symbol'] = instance.symbol;

  return json;
}
