part of "../models/currencies.dart";

Currencies _$CurrenciesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;
  String? symbol;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];
  if (json['symbol'] != null) symbol = json['symbol'];

  return Currencies(
    code: code,
    name: name,
    symbol: symbol,
  );
}

Map<String, dynamic> _$CurrenciesToJson(Currencies instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.symbol != null) json['symbol'] = instance.symbol;

  return json;
}
