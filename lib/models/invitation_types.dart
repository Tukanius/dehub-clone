part '../parts/invitation_types.dart';

class InvitationTypes {
  String? code;
  String? name;

  InvitationTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$InvitationTypesFromJson(json);
  factory InvitationTypes.fromJson(Map<String, dynamic> json) =>
      _$InvitationTypesFromJson(json);
  Map<String, dynamic> toJson() => _$InvitationTypesToJson(this);
}
