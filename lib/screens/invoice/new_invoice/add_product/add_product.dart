import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/screens/invoice/new_invoice/add_product/add_product_tabs/bagtsaar.dart';
import 'package:dehub/screens/invoice/new_invoice/add_product/add_product_tabs/shirhegeer.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddProductArguments {
  ListenController goodsListenController;
  List<Invoice> data;
  String businessId;
  AddProductArguments({
    required this.goodsListenController,
    required this.data,
    required this.businessId,
  });
}

class AddProduct extends StatefulWidget {
  final List<Invoice> data;
  final ListenController goodsListenController;
  final String businessId;
  static const routeName = '/addproduct';
  const AddProduct({
    required this.data,
    required this.businessId,
    Key? key,
    required this.goodsListenController,
  }) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: invoiceColor,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: invoiceColor,
                padding: const EdgeInsets.all(13),
                child: SvgPicture.asset(
                  'images/close.svg',
                  height: 30,
                ),
              ),
            ),
            title: Text(
              'Бараа сонгож нэмэх',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            centerTitle: true,
            actions: [
              AddButton(
                addColor: invoiceColor,
                color: white,
                onClick: () {},
              ),
            ],
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        color: white,
                        child: TabBar(
                          labelColor: invoiceColor,
                          unselectedLabelColor: grey3,
                          indicatorColor: invoiceColor,
                          tabs: [
                            Container(
                              alignment: Alignment.center,
                              height: 48,
                              child: Text('Багцаар'),
                            ),
                            Container(
                              child: Text('Ширхэгээр'),
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
              physics: NeverScrollableScrollPhysics(),
              children: [
                Bagtsaar(
                  data: widget.data,
                  goodsListenController: widget.goodsListenController,
                  businessId: widget.businessId,
                ),
                Shirhegeer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
