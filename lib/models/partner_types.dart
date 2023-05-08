part '../parts/partner_types.dart';

class PartnerTypes {
  String? code;
  String? name;

  PartnerTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$PartnerTypesFromJson(json);
  factory PartnerTypes.fromJson(Map<String, dynamic> json) =>
      _$PartnerTypesFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerTypesToJson(this);
}
