import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
part '../parts/business.dart';

class BusinessStaffs {
  final GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  String? id;
  String? avatar;
  String? lastName;
  String? firstName;
  String? phone;
  String? email;
  String? userStatus;

  BusinessStaffs({
    this.id,
    this.avatar,
    this.lastName,
    this.firstName,
    this.phone,
    this.email,
    this.userStatus,
  });

  static $fromJson(Map<String, dynamic> json) => _$BusinessStaffsFromJson(json);

  factory BusinessStaffs.fromJson(Map<String, dynamic> json) =>
      _$BusinessStaffsFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessStaffsToJson(this);
}
