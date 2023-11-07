part '../parts/result.dart';

class Filter {
  String? query;
  bool? isReceived;
  String? type;
  String? orderConfirmTerm;
  bool? isParent;
  String? businessId;
  String? regNumber;
  String? partnerName;
  String? staffId;
  String? regionId;
  String? categoryId;
  String? priorityId;
  String? paymentTermId;
  String? condition;
  String? configType;
  String? partnerId;
  String? pullSheetStatus;
  String? deliveryNoteStatus;
  String? status;

  String? startDate;
  String? endDate;
  String? paymentMethod;
  String? inOutType;
  String? accountId;

  Filter({
    this.accountId,
    this.startDate,
    this.endDate,
    this.paymentMethod,
    this.inOutType,
    this.status,
    this.deliveryNoteStatus,
    this.pullSheetStatus,
    this.partnerId,
    this.condition,
    this.configType,
    this.regNumber,
    this.partnerName,
    this.staffId,
    this.regionId,
    this.categoryId,
    this.priorityId,
    this.paymentTermId,
    this.businessId,
    this.isParent,
    this.type,
    this.query,
    this.isReceived,
    this.orderConfirmTerm,
  });
}

class Offset {
  int? page;
  int? limit;

  Offset({this.page, this.limit});
}

class ResultArguments {
  Filter? filter = Filter();
  Offset? offset = Offset(page: 1, limit: 10);

  ResultArguments({
    this.filter,
    this.offset,
  });

  Map<String, dynamic> toJson() => _$ResultArgumentToJson(this);
}

class Result {
  List<dynamic>? rows = [];
  int? count = 0;
  int? notSeen = 0;

  Result({this.rows, this.count, this.notSeen});

  factory Result.fromJson(dynamic json, Function fromJson) =>
      _$ResultFromJson(json, fromJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
