part '../parts/bank_names.dart';

class BankNames {
  String? code;
  String? bankCode;
  String? name;
  String? icon;

  BankNames({
    this.code,
    this.bankCode,
    this.name,
    this.icon,
  });

  static $fromJson(Map<String, dynamic> json) => _$BankNamesFromJson(json);

  factory BankNames.fromJson(Map<String, dynamic> json) =>
      _$BankNamesFromJson(json);

  Map<String, dynamic> toJson() => _$BankNamesToJson(this);
}
