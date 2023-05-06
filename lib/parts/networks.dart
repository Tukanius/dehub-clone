part of "../models/networks.dart";

Networks _$NetworksFromJson(Map<String, dynamic> json) {
  String? id;
  String? profileName;

  if (json['id'] != null) id = json['id'];
  if (json['profileName'] != null) profileName = json['profileName'];

  return Networks(
    id: id,
    profileName: profileName,
  );
}

Map<String, dynamic> _$NetworksToJson(Networks instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['id'] = instance.id;
  if (instance.profileName != null) json['profileName'] = instance.profileName;

  return json;
}
