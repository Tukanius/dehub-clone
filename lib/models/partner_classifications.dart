part '../parts/partner_classifications.dart';

class PartnerClassifications {
  String? code;
  String? name;

  PartnerClassifications({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$PartnerClassificationsFromJson(json);
  factory PartnerClassifications.fromJson(Map<String, dynamic> json) =>
      _$PartnerClassificationsFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerClassificationsToJson(this);
}
