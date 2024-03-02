import 'package:dehub/src/order_module/screens/dropship_order/tabs/dropshipping_tab.dart';
import 'package:dehub/src/order_module/screens/dropship_order/tabs/non_dropshipping_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class DropshipOrder extends StatefulWidget {
  static const routeName = '/DropshipOrder';
  const DropshipOrder({super.key});

  @override
  State<DropshipOrder> createState() => DropshipOrderState();
}

class DropshipOrderState extends State<DropshipOrder> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: orderColor),
          surfaceTintColor: white,
          backgroundColor: white,
          title: const Text(
            'Захиалгын жагсаалт',
            style: TextStyle(
              color: orderColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: TabBar(
            labelColor: orderColor,
            indicatorColor: orderColor,
            unselectedLabelColor: grey2,
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
            tabs: const [
              Tab(
                text: 'Манайхаас хүргэх',
              ),
              Tab(
                text: 'Нийлүүлэгч хүргэх',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DropshippingTab(),
            NonDropshippingTab(),
          ],
        ),
      ),
    );
  }
}
