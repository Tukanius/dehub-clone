import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/providers/invoice_provider.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/add_product/add_product_tabs/bagtsaar.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/add_product/add_product_tabs/shirhegeer.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class AddProductArguments {
  String businessId;
  String discountAmount;
  String shippingAmount;
  AddProductArguments({
    required this.businessId,
    required this.discountAmount,
    required this.shippingAmount,
  });
}

class AddProduct extends StatefulWidget {
  final String businessId;
  final String discountAmount;
  final String shippingAmount;
  static const routeName = '/addproduct';
  const AddProduct({
    required this.businessId,
    required this.shippingAmount,
    required this.discountAmount,
    super.key,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> with AfterLayoutMixin {
  @override
  afterFirstLayout(BuildContext context) {
    Provider.of<InvoiceProvider>(context, listen: false).packageProductClear();
  }

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
            title: const Text(
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
                      const SizedBox(
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
                              child: const Text('Багцаар'),
                            ),
                            Container(
                              height: 48,
                              alignment: Alignment.center,
                              color: transparent,
                              child: const Text('Ширхэгээр'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Bagtsaar(
                  discountAmount: widget.discountAmount,
                  shippingAmount: widget.shippingAmount,
                  isPackage: true,
                  businessId: widget.businessId,
                ),
                Shirhegeer(
                  discountAmount: widget.discountAmount,
                  shippingAmount: widget.shippingAmount,
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
