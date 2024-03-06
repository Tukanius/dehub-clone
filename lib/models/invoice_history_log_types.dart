part '../parts/invoice_history_log_types.dart';

class InvoiceHistoryLogTypes {
  String? code;
  String? name;

  InvoiceHistoryLogTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$InvoiceHistoryLogTypesFromJson(json);
  factory InvoiceHistoryLogTypes.fromJson(Map<String, dynamic> json) =>
      _$InvoiceHistoryLogTypesFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceHistoryLogTypesToJson(this);
}
