part of "../models/networks.dart";

Networks _$NetworksFromJson(Map<String, dynamic> json) {
  return Networks(
    id: json['id'] != null ? json['id'] as String : null,
    profileName:
        json['profileName'] != null ? json['profileName'] as String : null,
  );
}

Map<String, dynamic> _$NetworksToJson(Networks instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['id'] = instance.id;
  if (instance.profileName != null) json['profileName'] = instance.profileName;

  return json;
}
