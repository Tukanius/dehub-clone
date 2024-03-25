part '../parts/network_types.dart';

class NetworkTypes {
  String? code;
  String? name;

  NetworkTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$NetworkTypesFromJson(json);
  factory NetworkTypes.fromJson(Map<String, dynamic> json) =>
      _$NetworkTypesFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkTypesToJson(this);
}
