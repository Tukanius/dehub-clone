import 'package:simple_moment/simple_moment.dart';
import 'package:intl/intl.dart';
part '../parts/bank_accounts.dart';

class BankAccounts {
  String id;
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

  String? partnerId;
  String? regUserId;
  String? balance;

  BankAccounts({
    required this.id,
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
    this.partnerId,
    this.regUserId,
    this.balance,
  });

  static $fromJson(Map<String, dynamic> json) => _$BankAccountsFromJson(json);

  factory BankAccounts.fromJson(Map<String, dynamic> json) =>
      _$BankAccountsFromJson(json);

  Map<String, dynamic> toJson() => _$BankAccountsToJson(this);
}
