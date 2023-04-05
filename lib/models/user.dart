import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
part '../parts/user.dart';

class User {
  final GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? sessionId;
  String? partnerId;
  String? currentBusinessId;
  String? firstName;
  String? lastName;
  String? avatar;
  int? phone;
  String? email;
  String? loginType;
  String? username;
  String? code;
  String? password;
  User? partner;
  String? refCode;
  String? type;
  String? businessName;
  String? businessNameEng;
  User? currentBusiness;
  String? purchaseType;
  String? profileName;
  String? profileNameEng;
  String? productCategoryType;
  String? serviceCategoryType;
  String? businessStatus;
  bool? isVatPayer;
  String? logo;
  String? userId;
  String? tokeyType;
  String? accessToken;
  String? refreshToken;
  String? sessionState;
  String? sessionScope;

  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.sessionId,
    this.partnerId,
    this.currentBusinessId,
    this.firstName,
    this.lastName,
    this.code,
    this.password,
    this.avatar,
    this.phone,
    this.email,
    this.loginType,
    this.username,
    this.partner,
    this.refCode,
    this.type,
    this.businessName,
    this.businessNameEng,
    this.currentBusiness,
    this.purchaseType,
    this.profileName,
    this.profileNameEng,
    this.productCategoryType,
    this.serviceCategoryType,
    this.businessStatus,
    this.isVatPayer,
    this.logo,
    this.userId,
    this.tokeyType,
    this.accessToken,
    this.refreshToken,
    this.sessionScope,
    this.sessionState,
  });

  static $fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
