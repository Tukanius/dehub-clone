import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/src/payment_module/sheets/update_account_sheet.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BankAccountDetailArguments {
  String id;
  BankAccountDetailArguments({
    required this.id,
  });
}

class BankAccountDetail extends StatefulWidget {
  static const routeName = "/BankAccountDetail";
  final String id;
  const BankAccountDetail({
    super.key,
    required this.id,
  });

  @override
  BankAccountDetailState createState() => BankAccountDetailState();
}

class BankAccountDetailState extends State<BankAccountDetail>
    with AfterLayoutMixin {
  bool isSwitch = false;
  Payment get = Payment();
  General general = General();
  bool isLoading = true;
  ListenController listenController = ListenController();

  @override
  afterFirstLayout(BuildContext context) async {
    get = await PaymentApi().bankAccountGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  getCurrency() {
    var res = general.currencies!
        .firstWhere((element) => element.code == get.currency)
        .name;
    return res;
  }

  @override
  void initState() {
    listenController.addListener(() async {
      var res = await PaymentApi().bankAccountGet(widget.id);
      setState(() {
        get = res;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).paymentGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: networkColor),
        title: const Text(
          'Дансны мэдээлэл',
          style: TextStyle(color: paymentColor, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(color: paymentColor),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      '${get.number}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: paymentColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      '${get.name}',
                      style: const TextStyle(fontSize: 15, color: grey2),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 15, bottom: 10),
                    child: const Text(
                      'Ерөнхий мэдээлэл',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: grey3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => UpdateAccountSheet(
                          shortName: get.shortName!,
                          isDefault: get.isDefault ?? false,
                          id: get.id!,
                          listenController: listenController,
                        ),
                      );
                    },
                    child: Container(
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Дансны товч нэр',
                            style: TextStyle(color: dark),
                          ),
                          Row(
                            children: [
                              Text(
                                '${get.shortName}',
                                style: const TextStyle(color: paymentColor),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset('assets/svg/edit.svg'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Банкны нэр',
                    secondText: "${get.bankName}",
                    secondTextColor: paymentColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Дансны нэр',
                    secondText: "${get.name}",
                    secondTextColor: paymentColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Дансны дугаар',
                    secondText: "${get.number}",
                    secondTextColor: paymentColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Дансны валют',
                    secondText: "${getCurrency()}",
                    secondTextColor: paymentColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Үндсэн эсэх',
                    secondText: get.isDefault == true ? "Тийм" : "Үгүй",
                    secondTextColor: paymentColor,
                    color: white,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: const Text(
                      'Бүртгэлийн мэдээлэл',
                      style:
                          TextStyle(color: grey3, fontWeight: FontWeight.w600),
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Партнер нэр',
                    secondText: "${get.business?.partner?.businessName}",
                    secondTextColor: paymentColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Партнер код',
                    secondText: "${get.business?.partner?.refCode}",
                    secondTextColor: paymentColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'ТТД',
                    secondText: "${get.business?.regNumber}",
                    secondTextColor: paymentColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Бизнесийн нэр',
                    secondText: "${get.business?.profileName}",
                    secondTextColor: paymentColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Бизнесийн код',
                    secondText: "${get.business?.refCode}",
                    secondTextColor: paymentColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Бүртгэсэн хэрэглэгч',
                    secondText:
                        "${get.regUser?.lastName?[0]}. ${get.regUser?.firstName}",
                    secondTextColor: paymentColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Бүртгэсэн огноо',
                    secondText: DateFormat("yyyy-MM-dd").format(get.createdAt!),
                    secondTextColor: paymentColor,
                    color: white,
                  ),
                ],
              ),
            ),
    );
  }
}
