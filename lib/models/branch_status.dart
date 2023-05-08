part '../parts/branch_status.dart';

class BranchStatus {
  String? code;
  String? name;

  BranchStatus({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$BranchStatusFromJson(json);
  factory BranchStatus.fromJson(Map<String, dynamic> json) =>
      _$BranchStatusFromJson(json);
  Map<String, dynamic> toJson() => _$BranchStatusToJson(this);
}
