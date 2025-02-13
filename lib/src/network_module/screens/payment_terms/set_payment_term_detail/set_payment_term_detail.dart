import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/network_module/screens/payment_terms/set_payment_term/set_payment_term.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SetPaymentTermDetailArguments {
  String id;
  ListenController listenController;
  SetPaymentTermDetailArguments({
    required this.id,
    required this.listenController,
  });
}

class SetPaymentTermDetail extends StatefulWidget {
  static const routeName = '/SetPaymentTermDetail';
  final String id;
  final ListenController listenController;
  const SetPaymentTermDetail({
    super.key,
    required this.listenController,
    required this.id,
  });

  @override
  State<SetPaymentTermDetail> createState() => _SetPaymentTermDetailState();
}

class _SetPaymentTermDetailState extends State<SetPaymentTermDetail>
    with AfterLayoutMixin {
  BusinessNetwork business = BusinessNetwork();
  bool isLoading = true;
  General general = General();
  Result configType = Result(count: 0, rows: []);
  User user = User();

  @override
  afterFirstLayout(BuildContext context) async {
    business = await BusinessApi().networkGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    widget.listenController.addListener(() async {
      setState(() {
        isLoading = true;
      });
      business = await BusinessApi().networkGet(widget.id);
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  paymentTermCondition() {
    var res = general.paymentTermConditions!
        .firstWhere(
            (element) => element.code == business.paymentTerm?.condition)
        .name;
    return res;
  }

  paymentTermConfigType() {
    var res = general.paymentTermConfigTypes!
        .firstWhere(
            (element) => element.code == business.paymentTerm?.configType)
        .text;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).businessUser;
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        elevation: 0,
        leadingWidth: 150,
        leading: const CustomBackButton(color: networkColor),
      ),
      body: SingleChildScrollView(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: networkColor,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, bottom: 15, top: 15),
                    child: const Text(
                      'Харилцагчийн мэдээлэл',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Партнерийн мэдээлэл',
                    secondText: '${business.partnerName}',
                    secondTextColor: networkColor,
                    labelTextColor: dark,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Партнер код',
                    secondText: '${business.partner?.refCode}',
                    secondTextColor: networkColor,
                    labelTextColor: dark,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Бизнесийн нэр',
                    secondText: '${business.profileName}',
                    secondTextColor: networkColor,
                    labelTextColor: dark,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Бизнес код',
                    secondText: '${business.refCode}',
                    secondTextColor: networkColor,
                    labelTextColor: dark,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Статус',
                          style: TextStyle(
                            color: dark,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xff71717A).withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          child: const Text(
                            'Идэвхтэй',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, bottom: 15, top: 15),
                    child: const Text(
                      'Төлбөрийн нөхцөл',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    secondText: business.paymentTerm?.condition != null
                        ? paymentTermCondition()
                        : "-",
                    labelText: 'Төлбөрийн хэлбэр',
                    // onClick: () {},
                    arrowColor: networkColor,
                    secondTextColor: networkColor,
                    labelTextColor: dark,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Төлбөрийн нөхцөл',
                    // onClick: () {},
                    secondText: business.paymentTerm?.description,
                    arrowColor: networkColor,
                    secondTextColor: networkColor,
                    labelTextColor: dark,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Эхлэл огноо',
                    secondTextColor: networkColor,
                    secondText: business.paymentTerm?.startDate != null
                        ? DateFormat("yyyy-MM-dd")
                            .format(business.paymentTerm!.startDate!)
                        : '-',
                    labelTextColor: dark,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Дуусах огноо',
                    secondTextColor: networkColor,
                    secondText: business.paymentTerm?.endDate != null
                        ? DateFormat("yyyy-MM-dd")
                            .format(business.paymentTerm!.endDate!)
                        : '-',
                    labelTextColor: dark,
                  ),
                  if (Permission().check(user, "NET_PT_SET"))
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          SetPaymentTerm.routeName,
                          arguments: SetPaymentTermArguments(
                            id: widget.id,
                            listenController: widget.listenController,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        color: transparent,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Өөрчлөх',
                              style: TextStyle(
                                color: networkColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              'assets/svg/edit.svg',
                              colorFilter: const ColorFilter.mode(
                                  networkColor, BlendMode.srcIn),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
