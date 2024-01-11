import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/order_page/tabs/order_tab/tabs/received_tab.dart';
import 'package:dehub/src/order_module/order_page/tabs/order_tab/tabs/sales_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderTab extends StatefulWidget {
  const OrderTab({super.key});

  @override
  State<OrderTab> createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab>
    with SingleTickerProviderStateMixin {
  User user = User();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Material(
                    color: white,
                    child: TabBar(
                      overlayColor:
                          MaterialStatePropertyAll(Colors.grey.shade100),
                      indicatorColor: orderColor,
                      unselectedLabelColor: buttonColor,
                      labelColor: orderColor,
                      labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      tabs: [
                        Container(
                          alignment: Alignment.center,
                          height: 45,
                          child: user.currentBusiness?.type == "SUPPLIER"
                              ? Text(
                                  'Илгээсэн(SO)',
                                  style: TextStyle(fontFamily: 'Montserrat'),
                                )
                              : Text(
                                  'Илгээсэн(PO)',
                                  style: TextStyle(fontFamily: 'Montserrat'),
                                ),
                        ),
                        user.currentBusiness?.type == "SUPPLIER"
                            ? Container(
                                alignment: Alignment.center,
                                height: 45,
                                child: Text(
                                  'Ирсэн(PO)',
                                  style: TextStyle(fontFamily: 'Montserrat'),
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: 45,
                                child: Text(
                                  'Ирсэн(SO)',
                                  style: TextStyle(fontFamily: 'Montserrat'),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
