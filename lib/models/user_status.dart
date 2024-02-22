part '../parts/user_status.dart';

class UserStatus {
  String? code;
  String? name;

  UserStatus({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$UserStatusFromJson(json);
  factory UserStatus.fromJson(Map<String, dynamic> json) =>
      _$UserStatusFromJson(json);
  Map<String, dynamic> toJson() => _$UserStatusToJson(this);
}
