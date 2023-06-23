part '../parts/client_classification.dart';

class ClientClassifications {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? businessId;
  String? regUserId;
  String? parentId;
  bool? isParent;
  String? refCode;
  String? name;
  String? description;

  ClientClassifications({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.businessId,
    this.regUserId,
    this.parentId,
    this.isParent,
    this.refCode,
    this.name,
    this.description,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$ClientClassificationsFromJson(json);

  factory ClientClassifications.fromJson(Map<String, dynamic> json) =>
      _$ClientClassificationsFromJson(json);
  Map<String, dynamic> toJson() => _$ClientClassificationsToJson(this);
}
