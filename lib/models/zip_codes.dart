part '../parts/zip_codes.dart';

class ZipCodes {
  String? code;
  String? name;
  String? parent;
  String? zone;
  ZipCodes({
    this.code,
    this.name,
    this.parent,
    this.zone,
  });

  static $fromJson(Map<String, dynamic> json) => _$ZipCodesFromJson(json);

  factory ZipCodes.fromJson(Map<String, dynamic> json) =>
      _$ZipCodesFromJson(json);
  Map<String, dynamic> toJson() => _$ZipCodesToJson(this);
}
