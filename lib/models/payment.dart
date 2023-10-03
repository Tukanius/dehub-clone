part '../parts/payment.dart';

class Payment {
  int? count;
  List<Payment>? rows;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? partnerId;
  String? businessId;
  String? regUserId;
  String? bankName;
  String? number;
  String? name;
  String? shortName;
  String? currency;
  bool? isDefault;
  bool? isVerified;
  bool? isActive;
  String? icon;
  Payment? business;
  String? regNumber;
  String? refCode;
  String? profileName;
  Payment? partner;
  String? businessName;
  Payment? regUser;
  String? avatar;
  String? firstName;
  String? lastName;

  Payment({
    this.count,
    this.rows,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.partnerId,
    this.businessId,
    this.regUserId,
    this.bankName,
    this.number,
    this.name,
    this.shortName,
    this.currency,
    this.isDefault,
    this.isVerified,
    this.isActive,
    this.icon,
    this.business,
    this.regNumber,
    this.refCode,
    this.profileName,
    this.partner,
    this.businessName,
    this.regUser,
    this.avatar,
    this.firstName,
    this.lastName,
  });

  static $fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
