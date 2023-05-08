part '../parts/permissions.dart';

class Permissions {
  String? module;
  String? description;
  bool? isView;
  bool? isCreate;
  bool? isEdit;
  bool? isReview;
  bool? isDelete;
  String? code;
  String? name;

  Permissions({
    this.code,
    this.name,
    this.module,
    this.description,
    this.isView,
    this.isCreate,
    this.isEdit,
    this.isReview,
    this.isDelete,
  });

  static $fromJson(Map<String, dynamic> json) => _$PermissionsFromJson(json);
  factory Permissions.fromJson(Map<String, dynamic> json) =>
      _$PermissionsFromJson(json);
  Map<String, dynamic> toJson() => _$PermissionsToJson(this);
}
