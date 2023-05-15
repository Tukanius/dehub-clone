import 'package:dehub/screens/network_page/tabs/dashboard_tab/partner_page/partner_detail_page/payment_condition_page/tabs/active_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class PaymentConditionPage extends StatefulWidget {
  static const routeName = 'PaymentConditionPage';
  const PaymentConditionPage({super.key});

  @override
  State<PaymentConditionPage> createState() => _PaymentConditionPageState();
}

class _PaymentConditionPageState extends State<PaymentConditionPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: networkColor,
            ),
          ),
          title: Text(
            'Төлбөрийн нөхцөл',
            style: TextStyle(
              color: networkColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Container(
                height: 40,
                child: Center(
                  child: Text(
                    'Идэвхтэй',
                    style: TextStyle(color: networkColor),
                  ),
                ),
              ),
              Container(
                height: 40,
                child: Center(
                  child: Text(
                    'Түүх',
                    style: TextStyle(color: networkColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ActiveTab(),
            Text('1'),
          ],
        ),
      ),
    );
  }
}
