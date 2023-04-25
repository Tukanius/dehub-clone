part '../parts/bank_accounts.dart';

class BankAccounts {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? businessId;
  String? bankName;
  String? number;
  String? name;
  String? shortName;
  String? currency;
  bool? isDefault;
  bool? isVerified;
  bool? isActive;
  String? icon;

  BankAccounts({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.businessId,
    this.bankName,
    this.number,
    this.name,
    this.shortName,
    this.currency,
    this.isActive,
    this.isVerified,
    this.isDefault,
    this.icon,
  });

  static $fromJson(Map<String, dynamic> json) => _$BankAccountsFromJson(json);
  factory BankAccounts.fromJson(Map<String, dynamic> json) =>
      _$BankAccountsFromJson(json);
  Map<String, dynamic> toJson() => _$BankAccountsToJson(this);
}
