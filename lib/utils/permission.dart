import 'package:dehub/models/partner.dart';
import 'package:dehub/models/user.dart';

class Permission {
  int? index;

  check(User user, String permission, {String? boolean}) {
    index =
        user.permissions!.indexWhere((element) => element.code == permission);
    if (index == -1) {
      return false;
    } else if (boolean?.toLowerCase() == 'iscreate') {
      int i = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isCreate == true);
      return i != -1 ? user.permissions![i].isCreate : false;
    } else if (boolean?.toLowerCase() == "isview") {
      int i = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isView == true);
      return i != -1 ? user.permissions![i].isView : false;
    } else if (boolean?.toLowerCase() == "isedit") {
      int i = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isEdit == true);
      return i != -1 ? user.permissions![i].isEdit : false;
    } else if (boolean?.toLowerCase() == "isreview") {
      int i = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isReview == true);
      return i != -1 ? user.permissions![i].isReview : false;
    } else if (boolean?.toLowerCase() == 'isdelete') {
      int i = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isDelete == true);
      return i != -1 ? user.permissions![i].isDelete : false;
    } else {
      return true;
    }
  }

  partnerCheck(Partner user, String permission, {String? boolean}) {
    index =
        user.permissions!.indexWhere((element) => element.code == permission);
    if (index == -1) {
      return false;
    } else if (boolean?.toLowerCase() == 'iscreate') {
      int i = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isCreate == true);
      return i != -1 ? user.permissions![i].isView : false;
    } else if (boolean?.toLowerCase() == "isview") {
      int i = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isView == true);
      return i != -1 ? user.permissions![i].isView : false;
    } else if (boolean?.toLowerCase() == "isedit") {
      int i = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isEdit == true);
      return i != -1 ? user.permissions![i].isEdit : false;
    } else if (boolean?.toLowerCase() == "isreview") {
      int i = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isReview == true);
      return i != -1 ? user.permissions![i].isReview : false;
    } else if (boolean?.toLowerCase() == 'isdelete') {
      int i = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isDelete == true);
      return i != -1 ? user.permissions![i].isDelete : false;
    } else {
      return true;
    }
  }
}
