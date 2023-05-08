part '../parts/service_category_types.dart';

class ServiceCategoryTypes {
  String? code;
  String? name;

  ServiceCategoryTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryTypesFromJson(json);
  factory ServiceCategoryTypes.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryTypesFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceCategoryTypesToJson(this);
}
