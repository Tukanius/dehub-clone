import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/src/finance_module/screens/repayment_detail/tabs/basic_information.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class RePaymentDetailArguments {
  String id;
  RePaymentDetailArguments({
    required this.id,
  });
}

class RePaymentDetail extends StatefulWidget {
  final String id;
  static const routeName = '/RePaymentDetail';
  const RePaymentDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<RePaymentDetail> createState() => _RePaymentDetailState();
}

class _RePaymentDetailState extends State<RePaymentDetail>
    with AfterLayoutMixin {
  Finance get = Finance();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    get = await FinanceApi().repaymentGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          surfaceTintColor: backgroundColor,
          leadingWidth: 100,
          leading: CustomBackButton(color: financingColor),
          elevation: 0,
        ),
        body: Column(
          children: [
            Material(
              color: white,
              elevation: 2,
              child: TabBar(
                overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
                unselectedLabelColor: buttonColor,
                indicatorColor: financingColor,
                labelColor: financingColor,
                tabs: [
                  Container(
                    height: 45,
                    child: Center(
                      child: Text('Үндсэн мэдээлэл'),
                    ),
                  ),
                  Container(
                    height: 45,
                    child: Center(
                      child: Text('Нэмэлт мэдээлэл'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: financingColor,
                      ),
                    )
                  : TabBarView(
                      children: [
                        BasicInformation(
                          data: get,
                        ),
                        Text('1'),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
