part '../parts/invoice_over_due_status.dart';

class InvoiceOverdueStatus {
  String? code;
  String? name;
  String? color;

  InvoiceOverdueStatus({
    this.color,
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$InvoiceOverdueStatusFromJson(json);
  factory InvoiceOverdueStatus.fromJson(Map<String, dynamic> json) =>
      _$InvoiceOverdueStatusFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceOverdueStatusToJson(this);
}
