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
      index = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isCreate == true);
      return user.permissions![index!].isCreate ?? false;
    } else if (boolean?.toLowerCase() == "isview") {
      index = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isView == true);
      return user.permissions![index!].isView ?? false;
    } else if (boolean?.toLowerCase() == "isedit") {
      index = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isEdit == true);
      return user.permissions![index!].isEdit ?? false;
    } else if (boolean?.toLowerCase() == "isreview") {
      index = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isReview == true);
      return user.permissions![index!].isReview ?? false;
    } else if (boolean?.toLowerCase() == 'isdelete') {
      index = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isDelete == true);
      return user.permissions![index!].isDelete ?? false;
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
      index = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isCreate == true);
      return user.permissions![index!].isCreate ?? false;
    } else if (boolean?.toLowerCase() == "isview") {
      index = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isView == true);
      return user.permissions![index!].isView ?? false;
    } else if (boolean?.toLowerCase() == "isedit") {
      index = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isEdit == true);
      return user.permissions![index!].isEdit ?? false;
    } else if (boolean?.toLowerCase() == "isreview") {
      index = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isReview == true);
      return user.permissions![index!].isReview ?? false;
    } else if (boolean?.toLowerCase() == 'isdelete') {
      index = user.permissions!.indexWhere(
          (element) => element.code == permission && element.isDelete == true);
      return user.permissions![index!].isDelete ?? false;
    } else {
      return true;
    }
  }
}
