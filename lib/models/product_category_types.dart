part '../parts/product_category_types.dart';

class ProductCategoryTypes {
  String? code;
  String? name;

  ProductCategoryTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryTypesFromJson(json);
  factory ProductCategoryTypes.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryTypesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCategoryTypesToJson(this);
}
