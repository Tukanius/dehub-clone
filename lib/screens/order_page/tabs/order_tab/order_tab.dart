import 'package:dehub/screens/order_page/tabs/order_tab/tabs/received_tab.dart';
import 'package:dehub/screens/order_page/tabs/order_tab/tabs/sales_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class OrderTab extends StatefulWidget {
  const OrderTab({super.key});

  @override
  State<OrderTab> createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                color: white,
                child: TabBar(
                  indicatorColor: orderColor,
                  unselectedLabelColor: buttonColor,
                  labelColor: orderColor,
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  tabs: [
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        child: Text(
                          'Борлуулалт',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        child: Text(
                          'Хүлээн авсан',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          children: [
            SalesTab(),
            ReceivedTab(),
          ],
        ),
      ),
    );
  }
}
