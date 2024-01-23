import 'package:dehub/src/order_module/screens/order_shipping/tabs/shipping.dart';
import 'package:dehub/src/order_module/screens/order_shipping/tabs/shipping_made.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class OrderShipping extends StatefulWidget {
  static const routeName = '/OrderShipping';
  const OrderShipping({super.key});

  @override
  State<OrderShipping> createState() => _OrderDeliveryState();
}

class _OrderDeliveryState extends State<OrderShipping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: orderColor,
          ),
        ),
        title: const Text(
          'Ачилт удирдлага',
          style: TextStyle(
            color: buttonColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            height: 36,
            width: 36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: grey,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Material(
                  color: white,
                  child: TabBar(
                    overlayColor:
                        MaterialStatePropertyAll(Colors.grey.shade100),
                    labelColor: orderColor,
                    indicatorColor: orderColor,
                    unselectedLabelColor: buttonColor,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: const Text(
                          'Ачилт хийх',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: const Text(
                          'Ачилт дууссан',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              Shipping(),
              ShippingMade(),
            ],
          ),
        ),
      ),
    );
  }
}
