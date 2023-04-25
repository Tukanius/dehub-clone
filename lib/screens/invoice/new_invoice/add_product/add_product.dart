import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/screens/invoice/new_invoice/add_product/add_product_tabs/bagtsaar.dart';
import 'package:dehub/screens/invoice/new_invoice/add_product/add_product_tabs/shirhegeer.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddProduct extends StatefulWidget {
  static const routeName = '/addproduct';
  const AddProduct({super.key});

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
            backgroundColor: brownButtonColor,
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: brownButtonColor,
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
                          labelColor: brownButtonColor,
                          unselectedLabelColor: grey3,
                          indicatorColor: brownButtonColor,
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
                      SearchButton(
                        color: brownButtonColor,
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Bagtsaar(
                    // data: ,
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
