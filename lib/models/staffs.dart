part '../parts/staffs.dart';

class Staffs {
  String? id;
  String? lastName;
  String? firstName;
  String? avatar;

  Staffs({
    this.id,
    this.lastName,
    this.firstName,
    this.avatar,
  });

  static $fromJson(Map<String, dynamic> json) => _$StaffsFromJson(json);
  factory Staffs.fromJson(Map<String, dynamic> json) => _$StaffsFromJson(json);
  Map<String, dynamic> toJson() => _$StaffsToJson(this);
}
