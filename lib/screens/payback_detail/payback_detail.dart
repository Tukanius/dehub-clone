import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/screens/payback_detail/tabs/basic_information.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class PaybackDetail extends StatefulWidget {
  static const routeName = '/PaybackDetail';
  const PaybackDetail({Key? key}) : super(key: key);

  @override
  State<PaybackDetail> createState() => _PaybackDetailState();
}

class _PaybackDetailState extends State<PaybackDetail> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
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
              child: TabBarView(
                children: [
                  BasicInformation(),
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
