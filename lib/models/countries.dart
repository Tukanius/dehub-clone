part '../parts/countries.dart';

class Countries {
  String? code;
  String? name;
  String? nameEng;

  Countries({
    this.code,
    this.nameEng,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$CountriesFromJson(json);
  factory Countries.fromJson(Map<String, dynamic> json) =>
      _$CountriesFromJson(json);
  Map<String, dynamic> toJson() => _$CountriesToJson(this);
}
