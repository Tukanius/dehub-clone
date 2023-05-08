part '../parts/contract_doc_types.dart';

class ContractDocTypes {
  String? code;
  String? name;

  ContractDocTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$ContractDocTypesFromJson(json);
  factory ContractDocTypes.fromJson(Map<String, dynamic> json) =>
      _$ContractDocTypesFromJson(json);
  Map<String, dynamic> toJson() => _$ContractDocTypesToJson(this);
}
