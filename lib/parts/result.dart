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
    if (instance.filter!.categoryId != null) {
      params['filter']['categoryId'] = instance.filter!.categoryId;
    }
    if (instance.filter!.priorityId != null) {
      params['filter']['priorityId'] = instance.filter!.priorityId;
    }
    if (instance.filter!.paymentTermId != null) {
      params['filter']['paymentTermId'] = instance.filter!.paymentTermId;
    }

    if (instance.offset!.page! > 0) {
      params['offset']['page'] = instance.offset!.page;
    }
    if (instance.offset!.limit! > 0) {
      params['offset']['limit'] = instance.offset!.limit;
    }
  }

  return params;
}
