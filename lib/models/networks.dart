part '../parts/networks.dart';

class Networks {
  String? id;
  String? profileName;

  Networks({
    this.id,
    this.profileName,
  });

  static $fromJson(Map<String, dynamic> json) => _$NetworksFromJson(json);
  factory Networks.fromJson(Map<String, dynamic> json) =>
      _$NetworksFromJson(json);
  Map<String, dynamic> toJson() => _$NetworksToJson(this);
}
