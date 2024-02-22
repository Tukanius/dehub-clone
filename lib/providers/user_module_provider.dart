import 'package:dehub/models/user.dart';
import 'package:flutter/material.dart';

class UserModuleProvider extends ChangeNotifier {
  User user = User();

  selectBusiness(User data) {
    user.business = data;
    notifyListeners();
  }

  selectRole(String id, String name) {
    user.roleId = id;
    user.roleName = name;
    notifyListeners();
  }

  selectRoleType(String type) {
    user.type = type;
    notifyListeners();
  }

  selectBranch(String id, String name) {
    user.branchId = id;
    user.branchName = name;
    notifyListeners();
  }

  selectAccessLevel(String code) {
    user.accessLevel = code;
    notifyListeners();
  }

  departmentUnit(String value) {
    user.departmentUnitId = value;
    user.departmentSubUnitId = null;
    user.employeeUnitId = null;
    notifyListeners();
  }

  departmentSubUnit(String value) {
    user.departmentSubUnitId = value;
    user.employeeUnitId = null;
    notifyListeners();
  }

  employeeUnit(String value) {
    user.employeeUnitId = value;
    notifyListeners();
  }

  profileImage(String value) {
    user.avatar = value;
    notifyListeners();
  }

  cardFront(String value) {
    user.identityCardFront = value;
    notifyListeners();
  }

  cardBack(String value) {
    user.identityCardBack = value;
    notifyListeners();
  }

  clearData() {
    user = User(
      socialLinks: [
        User(type: 'FACEBOOK'),
        User(type: 'VIBER'),
        User(type: 'TELEGRAM'),
        User(type: 'INSTAGRAM'),
        User(type: 'TWITTER'),
      ],
    );
  }
}
