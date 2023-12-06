import 'package:dehub/src/order_module/screens/delivery_management/tabs/distribution_made_tab.dart';
import 'package:dehub/src/order_module/screens/delivery_management/tabs/distribution_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class DeliveryManagement extends StatefulWidget {
  static const routeName = '/DeliveryManagement';
  const DeliveryManagement({Key? key}) : super(key: key);

  @override
  State<DeliveryManagement> createState() => _DeliveryManagementState();
}

class _DeliveryManagementState extends State<DeliveryManagement> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: white,
          surfaceTintColor: white,
          elevation: 0,
          iconTheme: IconThemeData(color: orderColor),
          title: Text(
            'Хүргэлт удирдлага',
            style: TextStyle(
              color: orderColor,
              fontSize: 17,
            ),
          ),
          bottom: TabBar(
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
            indicatorColor: orderColor,
            labelColor: orderColor,
            unselectedLabelColor: grey2,
            tabs: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text(
                    'Хүргэлт хуваарилах',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text(
                    'Хүргэлт хуваарилсан',
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DistributionTab(),
            DistributionMadeTab(),
          ],
        ),
      ),
    );
  }
}
