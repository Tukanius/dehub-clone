part '../parts/legal_entity_types.dart';

class LegalEntityTypes {
  String? code;
  String? name;

  LegalEntityTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$LegalEntityTypesFromJson(json);
  factory LegalEntityTypes.fromJson(Map<String, dynamic> json) =>
      _$LegalEntityTypesFromJson(json);
  Map<String, dynamic> toJson() => _$LegalEntityTypesToJson(this);
}
