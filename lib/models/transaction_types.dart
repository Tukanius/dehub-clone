part '../parts/transaction_types.dart';

class TransactionTypes {
  String? code;
  String? name;

  TransactionTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$TransactionTypesFromJson(json);
  factory TransactionTypes.fromJson(Map<String, dynamic> json) =>
      _$TransactionTypesFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionTypesToJson(this);
}
