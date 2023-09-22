part '../parts/delivery_note_status.dart';

class DeliveryNoteStatus {
  String? code;
  String? name;
  String? color;

  DeliveryNoteStatus({
    this.code,
    this.name,
    this.color,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$DeliveryNoteStatusFromJson(json);
  factory DeliveryNoteStatus.fromJson(Map<String, dynamic> json) =>
      _$DeliveryNoteStatusFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryNoteStatusToJson(this);
}
