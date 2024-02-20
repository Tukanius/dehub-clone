part '../parts/partner_staffs.dart';

class PartnerStaffs {
  String? id;
  String? registerNo;
  String? familyName;
  String? lastName;
  String? firstName;
  String? phone;
  String? email;
  String? avatar;

  PartnerStaffs({
    this.id,
    this.registerNo,
    this.familyName,
    this.lastName,
    this.firstName,
    this.phone,
    this.email,
    this.avatar,
  });

  static $fromJson(Map<String, dynamic> json) => _$PartnerStaffsFromJson(json);
  factory PartnerStaffs.fromJson(Map<String, dynamic> json) =>
      _$PartnerStaffsFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerStaffsToJson(this);
}
