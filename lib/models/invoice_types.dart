part '../parts/invoice_types.dart';

class InvoiceTypes {
  String? code;
  String? name;

  InvoiceTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$InvoiceTypesFromJson(json);
  factory InvoiceTypes.fromJson(Map<String, dynamic> json) =>
      _$InvoiceTypesFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceTypesToJson(this);
}
