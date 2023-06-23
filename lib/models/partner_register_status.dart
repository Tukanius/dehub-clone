part '../parts/partner_register_status.dart';

class PartnerRegisterStatus {
  String? code;
  String? name;
  String? color;

  PartnerRegisterStatus({
    this.code,
    this.name,
    this.color,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$PartnerRegisterStatusFromJson(json);
  factory PartnerRegisterStatus.fromJson(Map<String, dynamic> json) =>
      _$PartnerRegisterStatusFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerRegisterStatusToJson(this);
}
