part '../parts/qpay_urls.dart';

class Urls {
  String? name;
  String? description;
  String? logo;
  Uri? link;

  Urls({
    this.name,
    this.description,
    this.logo,
    this.link,
  });

  static $fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);
  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}
