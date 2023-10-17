import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/new_order/new_order.dart';
import 'package:dehub/screens/order_page/tabs/order_tab/tabs/received_tab.dart';
import 'package:dehub/screens/order_page/tabs/order_tab/tabs/sales_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderTab extends StatefulWidget {
  const OrderTab({super.key});

  @override
  State<OrderTab> createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;

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
                        child: user.currentBusiness?.type == "SUPPLIER"
                            ? Text(
                                'Борлуулалт',
                                style: TextStyle(fontFamily: 'Montserrat'),
                              )
                            : Text(
                                'Худалдан авалт',
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
            Stack(
              children: [
                SalesTab(),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    backgroundColor: orderColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        NewOrder.routeName,
                        arguments: NewOrderArguments(id: null),
                      );
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
            ReceivedTab(),
          ],
        ),
      ),
    );
  }
}
