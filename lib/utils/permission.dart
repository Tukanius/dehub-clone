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
      return user.permissions![index!].isCreate;
    } else if (boolean?.toLowerCase() == "isview") {
      return user.permissions![index!].isView;
    } else if (boolean?.toLowerCase() == "isedit") {
      return user.permissions![index!].isEdit;
    } else if (boolean?.toLowerCase() == "isreview") {
      return user.permissions![index!].isReview;
    } else if (boolean?.toLowerCase() == 'isdelete') {
      return user.permissions![index!].isDelete;
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
      return user.permissions![index!].isCreate;
    } else if (boolean?.toLowerCase() == "isview") {
      return user.permissions![index!].isView;
    } else if (boolean?.toLowerCase() == "isedit") {
      return user.permissions![index!].isEdit;
    } else if (boolean?.toLowerCase() == "isreview") {
      return user.permissions![index!].isReview;
    } else if (boolean?.toLowerCase() == 'isdelete') {
      return user.permissions![index!].isDelete;
    } else {
      return true;
    }
  }
}
