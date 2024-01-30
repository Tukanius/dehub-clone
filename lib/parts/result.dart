part of '../models/result.dart';

Result _$ResultFromJson(dynamic res, Function fromJson) {
  Map<String, dynamic>? json;
  List<dynamic>? results;

  if (res.runtimeType == <dynamic>[].runtimeType) {
    results = res as List?;

    return Result(
        rows: results!
            .map((json) => fromJson(json as Map<String, dynamic>))
            .toList(),
        count: results.length);
  } else {
    json = res as Map<String, dynamic>?;
    return Result(
      rows: (json!['rows'] as List)
          .map((json) => fromJson(json as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int?,
    );
  }
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'rows': instance.rows,
      'count': instance.count,
    };

Map<String, dynamic> _$ResultArgumentToJson(ResultArguments? instance) {
  Map<String, dynamic> params = {};

  if (instance != null) {
    params['offset'] = {};
    params['filter'] = {};

    if (instance.filter!.accountId != null) {
      params['filter']['accountId'] = instance.filter!.accountId;
    }
    if (instance.filter!.repaymentId != null) {
      params['filter']['repaymentId'] = instance.filter!.repaymentId;
    }
    if (instance.filter!.financeType != null) {
      params['filter']['financeType'] = instance.filter!.financeType;
    }
    if (instance.filter!.programId != null) {
      params['filter']['programId'] = instance.filter!.programId;
    }
    if (instance.filter!.supplierId != null) {
      params['filter']['supplierId'] = instance.filter!.supplierId;
    }
    if (instance.filter!.isService != null) {
      params['filter']['isService'] = instance.filter!.isService;
    }
    if (instance.filter!.isEmail != null) {
      params['filter']['isEmail'] = instance.filter!.isEmail;
    }
    if (instance.filter!.isGoods != null) {
      params['filter']['isGoods'] = instance.filter!.isGoods;
    }
    if (instance.filter!.invoiceId != null) {
      params['filter']['invoiceId'] = instance.filter!.invoiceId;
    }
    if (instance.filter!.isContracted != null) {
      params['filter']['isContracted'] = instance.filter!.isContracted;
    }
    if (instance.filter!.productType != null) {
      params['filter']['productType'] = instance.filter!.productType;
    }
    if (instance.filter!.startDate != null) {
      params['filter']['startDate'] = instance.filter!.startDate;
    }
    if (instance.filter!.endDate != null) {
      params['filter']['endDate'] = instance.filter!.endDate;
    }
    if (instance.filter!.paymentMethod != null) {
      params['filter']['paymentMethod'] = instance.filter!.paymentMethod;
    }
    if (instance.filter!.inOutType != null) {
      params['filter']['inOutType'] = instance.filter!.inOutType;
    }
    if (instance.filter!.isRecalled != null) {
      params['filter']['isRecalled'] = instance.filter!.isRecalled;
    }
    if (instance.filter!.businessId != null) {
      params['filter']['businessId'] = instance.filter!.businessId;
    }
    if (instance.filter!.query != null) {
      params['filter']['query'] = instance.filter!.query;
    }
    if (instance.filter!.condition != null) {
      params['filter']['condition'] = instance.filter!.condition;
    }
    if (instance.filter!.configType != null) {
      params['filter']['configType'] = instance.filter!.configType;
    }
    if (instance.filter!.isReceived != null) {
      params['filter']['isReceived'] = instance.filter!.isReceived;
    }

    if (instance.filter!.type != null) {
      params['filter']['type'] = instance.filter!.type;
    }
    if (instance.filter!.orderConfirmTerm != null) {
      params['filter']['orderConfirmTerm'] = instance.filter!.orderConfirmTerm;
    }
    if (instance.filter!.isParent != null) {
      params['filter']['isParent'] = instance.filter!.isParent;
    }
    if (instance.filter!.pullSheetStatus != null) {
      params['filter']['pullSheetStatus'] = instance.filter!.pullSheetStatus;
    }
    if (instance.filter!.regNumber != null) {
      params['filter']['regNumber'] = instance.filter!.regNumber;
    }
    if (instance.filter!.partnerName != null) {
      params['filter']['partnerName'] = instance.filter!.partnerName;
    }
    if (instance.filter!.staffId != null) {
      params['filter']['staffId'] = instance.filter!.staffId;
    }
    if (instance.filter!.partnerId != null) {
      params['filter']['partnerId'] = instance.filter!.partnerId;
    }
    if (instance.filter!.regionId != null) {
      params['filter']['regionId'] = instance.filter!.regionId;
    }
    if (instance.filter!.status != null) {
      params['filter']['status'] = instance.filter!.status;
    }
    if (instance.filter!.categoryId != null) {
      params['filter']['categoryId'] = instance.filter!.categoryId;
    }
    if (instance.filter!.priorityId != null) {
      params['filter']['priorityId'] = instance.filter!.priorityId;
    }
    if (instance.filter!.paymentTermId != null) {
      params['filter']['paymentTermId'] = instance.filter!.paymentTermId;
    }
    if (instance.filter!.deliveryNoteStatus != null) {
      params['filter']['deliveryNoteStatus'] =
          instance.filter!.deliveryNoteStatus;
    }
    if (instance.filter!.itemStatus != null) {
      params['filter']['itemStatus'] = instance.filter!.itemStatus;
    }

    if (instance.offset!.page! != 0) {
      params['offset']['page'] = instance.offset!.page;
    }
    if (instance.offset?.limit != 0) {
      params['offset']['limit'] = instance.offset!.limit;
    }
  }

  return params;
}
