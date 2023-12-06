import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/add_product/add_product_tabs/bagtsaar.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/add_product/add_product_tabs/shirhegeer.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddProductArguments {
  String businessId;
  AddProductArguments({
    required this.businessId,
  });
}

class AddProduct extends StatefulWidget {
  final String businessId;
  static const routeName = '/addproduct';
  const AddProduct({
    required this.businessId,
    Key? key,
  }) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: invoiceColor,
            surfaceTintColor: invoiceColor,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: invoiceColor,
                padding: const EdgeInsets.all(13),
                child: SvgPicture.asset(
                  'assets/svg/close.svg',
                  height: 30,
                ),
              ),
            ),
            title: Text(
              'Бараа сонгож нэмэх',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: white,
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
                      SizedBox(
                        height: 10,
                      ),
                      Material(
                        color: white,
                        child: TabBar(
                          overlayColor:
                              MaterialStatePropertyAll(Colors.grey.shade100),
                          labelColor: invoiceColor,
                          unselectedLabelColor: grey3,
                          indicatorColor: invoiceColor,
                          tabs: [
                            Container(
                              color: transparent,
                              alignment: Alignment.center,
                              height: 48,
                              child: Text('Багцаар'),
                            ),
                            Container(
                              height: 48,
                              alignment: Alignment.center,
                              color: transparent,
                              child: Text('Ширхэгээр'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                  isPackage: true,
                  businessId: widget.businessId,
                ),
                Shirhegeer(
                  isPackage: false,
                  businessId: widget.businessId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
