import 'package:dehub/models/business.dart';
import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/invitation_received.dart';
import 'package:dehub/models/reference_information.dart';
import 'package:dehub/models/reference_information_get.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/utils/http_request.dart';

class BusinessApi extends HttpRequest {
  Future<Result> list(ResultArguments resultArguments) async {
    var res = await get('/invitation/received/', "BUSINESS", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, InvitationReceived.$fromJson);
  }

  Future<Result> listSent(ResultArguments resultArguments) async {
    var res = await get('/invitation/sent/', "BUSINESS", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, InvitationReceived.$fromJson);
  }

  Future<InvitationReceived> getInfo(String id) async {
    var res = await get(
      "/invitation/$id",
      "BUSINESS",
      true,
    );
    return InvitationReceived.fromJson(res as Map<String, dynamic>);
  }

  // respond(String id, InvitationReceived data) async {
  //   var res = await put("/invitation/$id/respond", "BUSINESS",
  //       handler: true, data: data.toJson());
  //   return InvitationReceived.fromJson(res as Map<String, dynamic>);
  // }

  respond(InvitationReceived data, String id) async {
    Map<String, dynamic> json = {};
    json['accept'] = data.accept == true;
    json['responseMessage'] = "accept";
    var res =
        await put("/invitation/$id/respond", "BUSINESS", true, data: json);
    return res['accept'] == true;
  }

  refuse(InvitationReceived data, String id) async {
    Map<String, dynamic> json = {};
    json['accept'] = data.accept == false;
    json['responseMessage'] = "accept";
    var res =
        await put("/invitation/$id/respond", "BUSINESS", true, data: json);
    return res['accept'] == false;
  }

  Future<Result> networkList(ResultArguments resultArguments) async {
    var res = await get("/network", "BUSINESS", true,
        data: resultArguments.toJson(), handler: true);
    return Result.fromJson(res, BusinessNetwork.$fromJson);
  }

  Future<BusinessNetwork> partnerDetail(String id) async {
    var res = get(
      "/network/$id",
      "BUSINESS",
      true,
    );
    return BusinessNetwork.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> referenceList(ResultArguments resultArguments) async {
    var res = await get("/reference", "BUSINESS", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, ReferenceInformation.$fromJson);
  }

  Future<Result> paymentTermList(ResultArguments resultArguments) async {
    var res = await get("/payment_term", "BUSINESS", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, ReferenceInformation.fromJson);
  }

  Future<Result> distributionAreaList(ResultArguments resultArguments) async {
    var res = await get("/distribution_area", "BUSINESS", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, ReferenceInformation.fromJson);
  }

  Future<Result> clientClassificationList(
      ResultArguments resultArguments) async {
    var res = await get("/client_classification", "BUSINESS", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, ReferenceInformation.fromJson);
  }

  Future<ReferenceInformationGet> paymentTermGet(String id) async {
    var res = await get(
      "/payment_term/$id",
      "BUSINESS",
      true,
    );
    return ReferenceInformationGet.fromJson(res as Map<String, dynamic>);
  }

  Future<ReferenceInformationGet> clientClassificationGet(String id) async {
    var res = await get(
      "/client_classification/$id",
      "BUSINESS",
      true,
    );
    return ReferenceInformationGet.fromJson(res as Map<String, dynamic>);
  }

  Future<ReferenceInformationGet> distrbutionAreaGet(String id) async {
    var res = await get(
      "/distribution_area/$id",
      "BUSINESS",
      true,
    );
    return ReferenceInformationGet.fromJson(res as Map<String, dynamic>);
  }

  Future<BusinessStaffs> createPaymentTerm(BusinessStaffs data) async {
    var res = await post("/payment_term", "BUSINESS", true,
        data: data.toJson(), handler: true);
    return BusinessStaffs.fromJson(res as Map<String, dynamic>);
  }

  Future<BusinessStaffs> createDistributionArea(BusinessStaffs data) async {
    var res =
        await post("/distribution_area", "BUSINESS", true, data: data.toJson());
    return BusinessStaffs.fromJson(res as Map<String, dynamic>);
  }

  Future<BusinessStaffs> createClientClassification(BusinessStaffs data) async {
    var res = await post("/client_classification", "BUSINESS", true,
        data: data.toJson());
    return BusinessStaffs.fromJson(res as Map<String, dynamic>);
  }
}
