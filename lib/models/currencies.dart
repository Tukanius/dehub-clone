part '../parts/currencies.dart';

class Currencies {
  String? code;
  String? name;
  String? symbol;

  Currencies({
    this.code,
    this.name,
    this.symbol,
  });

  static $fromJson(Map<String, dynamic> json) => _$CurrenciesFromJson(json);
  factory Currencies.fromJson(Map<String, dynamic> json) =>
      _$CurrenciesFromJson(json);
  Map<String, dynamic> toJson() => _$CurrenciesToJson(this);
}
