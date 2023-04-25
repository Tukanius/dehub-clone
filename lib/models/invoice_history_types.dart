part '../parts/invoice_history_types.dart';

class InvoiceHistoryTypes {
  String? code;
  String? name;

  InvoiceHistoryTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$InvoiceHistoryTypesFromJson(json);
  factory InvoiceHistoryTypes.fromJson(Map<String, dynamic> json) =>
      _$InvoiceHistoryTypesFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceHistoryTypesToJson(this);
}
