part '../parts/branch_types.dart';

class BranchTypes {
  String? code;
  String? name;

  BranchTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$BranchTypesFromJson(json);
  factory BranchTypes.fromJson(Map<String, dynamic> json) =>
      _$BranchTypesFromJson(json);
  Map<String, dynamic> toJson() => _$BranchTypesToJson(this);
}
