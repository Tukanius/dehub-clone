part '../parts/reference_list_types.dart';

class ReferenceListTypes {
  String? code;
  String? name;
  ReferenceListTypes? COD;
  ReferenceListTypes? INV_NET2;
  ReferenceListTypes? AR_NET30;
  ReferenceListTypes? REGION;
  ReferenceListTypes? DIRECTION;
  ReferenceListTypes? CLIENT_CATEGORY;
  ReferenceListTypes? CLIENT_PRIORITY;

  ReferenceListTypes({
    this.code,
    this.name,
    this.COD,
    this.INV_NET2,
    this.AR_NET30,
    this.REGION,
    this.DIRECTION,
    this.CLIENT_CATEGORY,
    this.CLIENT_PRIORITY,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$ReferenceListTypesFromJson(json);
  factory ReferenceListTypes.fromJson(Map<String, dynamic> json) =>
      _$ReferenceListTypesFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceListTypesToJson(this);
}
