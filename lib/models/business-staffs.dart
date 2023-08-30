import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
part '../parts/business-staffs.dart';

class BusinessStaffs {
  final GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  String? id;
  String? avatar;
  String? lastName;
  String? firstName;
  String? phone;
  String? email;
  String? userStatus;
  String? termRule;
  String? orderConfirmTerm;
  int? expireDayCount;
  int? month;
  int? paymentDay;
  String? name;
  String? parentId;
  String? description;

  BusinessStaffs({
    this.name,
    this.parentId,
    this.description,
    this.termRule,
    this.orderConfirmTerm,
    this.expireDayCount,
    this.month,
    this.paymentDay,
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
