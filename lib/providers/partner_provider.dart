import 'package:dehub/api/partner_api.dart';
import 'package:dehub/models/partner.dart';
import 'package:flutter/material.dart';

class PartnerProvider extends ChangeNotifier {
  List<Partner> images = [];
  Partner partner = Partner();
  List<Partner> buyers = [];
  List<Partner> suppliers = [];
  Partner createdBranch = Partner();
  bool isSubmit = false;

  loading(bool value) {
    isSubmit = value;
    notifyListeners();
  }

  departmentUnit(String id) {
    partner.departmentUnitId = id;
    partner.employeeUnitId = null;
    notifyListeners();
  }

  employeeUnit(String id) {
    partner.employeeUnitId = id;
    notifyListeners();
  }

  classification(String value) {
    partner.classification = value;
    notifyListeners();
  }

  province(String? value) {
    partner.province = value;
    partner.district = null;
    notifyListeners();
  }

  district(String? value) {
    partner.district = value;
    partner.khoroo = null;
    notifyListeners();
  }

  khoroo(String? value) {
    partner.khoroo = value;
    notifyListeners();
  }

  partnerCategory(String? value) {
    partner.partnerCategory = value;
    notifyListeners();
  }

  equityType(String? value) {
    partner.equityType = value;
    notifyListeners();
  }

  country(String? value) {
    partner.country = value;
    notifyListeners();
  }

  legalEntityType(String value) {
    partner.legalEntityType = value;
    notifyListeners();
  }

  branchCreate(Partner data) async {
    createdBranch = await PartnerApi().branchCreate(data);
    notifyListeners();
  }

  partnerStaff(String id) {
    partner.warehouseUserId = id;
    notifyListeners();
  }

  warehouseStatus(String value) {
    partner.warehouseStatus = value;
    notifyListeners();
  }

  branchUpdate(Partner data, String id) async {
    createdBranch = await PartnerApi().branchUpdate(data, id);
    notifyListeners();
  }

  bannerImages(Partner value) {
    images.add(value);
    partner.profileBanners = images;
    notifyListeners();
  }

  removeBannerImage(int index) {
    partner.profileBanners?.removeAt(index);
    notifyListeners();
  }

  profileImage(String value) {
    partner.logo = value;
    notifyListeners();
  }

  clearData() {
    images = [];
    buyers = [];
    suppliers = [];
    createdBranch = Partner();
    partner = Partner();
    notifyListeners();
  }

  selectBuyer(Partner value) {
    buyers.add(value);
    notifyListeners();
  }

  selectSupplier(Partner value) {
    suppliers.add(value);
    notifyListeners();
  }

  branchType(String value) {
    partner.type = value;
    notifyListeners();
  }
}
