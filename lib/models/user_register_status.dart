part '../parts/user_register_status.dart';

class UserRegisterStatus {
  String? code;
  String? name;
  String? color;

  UserRegisterStatus({
    this.code,
    this.name,
    this.color,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$UserRegisterStatusFromJson(json);
  factory UserRegisterStatus.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterStatusFromJson(json);
  Map<String, dynamic> toJson() => _$UserRegisterStatusToJson(this);
}
