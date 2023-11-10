import 'package:dehub/models/business-staffs.dart';
import 'package:dehub/models/business.dart';
import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/invitation_received.dart';
import 'package:dehub/models/reference_information.dart';
import 'package:dehub/models/reference_information_get.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/utils/http_request.dart';

class BusinessApi extends HttpRequest {
  Future<Result> list(ResultArguments resultArguments) async {
    var res = await get('/invitation/received', "BUSINESS", true,
        handler: true, data: resultArguments.toJson());
    return Result.fromJson(res, Invitation.fromJson);
  }

  Future<Result> funder(ResultArguments resultArguments) async {
    var res = await get('/invitation/funder', "BUSINESS", true,
        handler: true, data: resultArguments.toJson());
    return Result.fromJson(res, Invitation.fromJson);
  }

  Future<Result> listSent(ResultArguments resultArguments) async {
    var res = await get('/invitation/sent', "BUSINESS", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Invitation.$fromJson);
  }

  Future<Invitation> getInfo(String id) async {
    var res = await get(
      "/invitation/$id",
      "BUSINESS",
      true,
    );
    return Invitation.fromJson(res as Map<String, dynamic>);
  }

  respond(Invitation data, String id) async {
    var res = await put("/invitation/$id/respond", "BUSINESS", true,
        data: data.toJson());
    return res;
  }

  Future<Result> networkList(ResultArguments resultArguments) async {
    var res = await get("/network", "BUSINESS", true,
        data: resultArguments.toJson(), handler: true);
    return Result.fromJson(res, BusinessNetwork.$fromJson);
  }

  Future<BusinessNetwork> networkGet(String id) async {
    var res = await get("/network/$id", "BUSINESS", true);
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

  Future<Result> businessList(ResultArguments resultArguments) async {
    var res = await get('/invitation/business_list', "BUSINESS", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Business.fromJson);
  }

  Future<Result> businessSuggest(ResultArguments resultArguments) async {
    var res = await get('/invitation/business_suggest', "BUSINESS", true,
        handler: true, data: resultArguments.toJson());
    return Result.fromJson(res, Business.fromJson);
  }

  Future<Business> createInvitation(Business data) async {
    var res = await post('/invitation', "BUSINESS", true,
        handler: true, data: data.toJson());
    return Business.fromJson(res as Map<String, dynamic>);
  }

  pieChart() async {
    var res = await get(
        '/dashboard/client_classification/stats', 'BUSINESS', true,
        handler: true);
    return res as Map<String, dynamic>;
  }

  Future<Business> dashboardSent() async {
    var res = await get('/dashboard/invitation/sent', 'BUSINESS', true,
        handler: true);
    return Business.fromJson(res as Map<String, dynamic>);
  }

  Future<Business> dashboardReceived() async {
    var res = await get('/dashboard/invitation/received', 'BUSINESS', true,
        handler: true);
    return Business.fromJson(res as Map<String, dynamic>);
  }

  Future<BusinessNetwork> setClientStaff(BusinessNetwork data) async {
    var res = await put('/network/set/client_staff', "BUSINESS", true,
        handler: true, data: data.toJson());
    return BusinessNetwork.fromJson(res as Map<String, dynamic>);
  }

  Future<BusinessNetwork> setPaymentTerm(BusinessNetwork data) async {
    var res = await put('/network/set/payment_term', "BUSINESS", true,
        data: data.toJson());
    return BusinessNetwork.fromJson(res as Map<String, dynamic>);
  }

  Future<BusinessNetwork> setDistributionArea(BusinessNetwork data) async {
    var res = await put('/network/set/distribution_area', "BUSINESS", true,
        data: data.toJson());
    return BusinessNetwork.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> paymentTermSelect(String condition) async {
    var res = await get(
        '/payment_term/select?condition=$condition', "BUSINESS", true);
    return Result.fromJson(res, Business.fromJson);
  }

  Future<BusinessNetwork> createOnboard(BusinessNetwork data) async {
    var res = await post('/invitation/onboarding', "BUSINESS", true,
        data: data.toJson());
    return BusinessNetwork.fromJson(res as Map<String, dynamic>);
  }

  Future<BusinessNetwork> setClientClassification(BusinessNetwork data) async {
    var res = await put('/network/set/client_classification', "BUSINESS", true,
        data: data.toJson());
    return BusinessNetwork.fromJson(res as Map<String, dynamic>);
  }

  Future<BusinessNetwork> setAccount(BusinessNetwork data) async {
    var res = await put('/network/set/account', "BUSINESS", true,
        data: data.toJson());
    return BusinessNetwork.fromJson(res as Map<String, dynamic>);
  }
}
