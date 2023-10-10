import 'dart:async';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/order_product_card/order_product_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
// import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class ProductChooseArguments {
  bool? isPackage;
  String businessId;
  ListenController productListenController;
  ListenController packageListenController;
  ProductChooseArguments({
    required this.packageListenController,
    this.isPackage,
    required this.businessId,
    required this.productListenController,
  });
}

class ProductChoose extends StatefulWidget {
  final bool? isPackage;
  final String businessId;
  final ListenController packageListenController;
  final ListenController productListenController;
  static const routeName = '/ProductChoose';
  const ProductChoose({
    Key? key,
    this.isPackage,
    required this.packageListenController,
    required this.businessId,
    required this.productListenController,
  }) : super(key: key);

  @override
  State<ProductChoose> createState() => _ProductChooseState();
}

class _ProductChooseState extends State<ProductChoose>
    with AfterLayoutMixin, SingleTickerProviderStateMixin {
  Result category = Result(count: 0, rows: []);
  Result order = Result(count: 0, rows: []);
  bool isLoading = true;
  String query = '';
  int limit = 10;
  Timer? timer;
  bool isSubmit = false;
  User user = User();
  String type = '';
  List<Order> packageProduct = [];

  @override
  afterFirstLayout(BuildContext context) async {
    order = await OrderApi().variantSelect(
        user.currentBusiness?.type == "SUPPLIER" ? "SALES" : "PURCHASE",
        '${widget.businessId}',
        query,
        '',
        '',
        '');
    category = await InventoryApi().category(
        user.currentBusiness?.type == "SUPPLIER" ? "SALES" : "PURCHASE",
        "${widget.businessId}");
    setState(() {
      isLoading = false;
    });
  }

  onChange(String value) async {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isSubmit = true;
      });
      order = await OrderApi().variantSelect(
          user.currentBusiness?.type == "SUPPLIER" ? "SALES" : "PURCHASE",
          'a',
          value,
          "",
          '${type}',
          '');
      setState(() {
        isSubmit = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: orderColor,
        elevation: 0,
        leading: CustomCloseButton(),
        title: Text(
          'Бараа сонгож нэмэх',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: orderColor,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SearchButton(
                          color: orderColor,
                          textColor: orderColor,
                          onChange: (query) {
                            onChange(query);
                          },
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: white,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: category.rows!
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          type = e.id;
                                        });
                                        setState(() {
                                          isSubmit = true;
                                        });
                                        order = await OrderApi().variantSelect(
                                            user.currentBusiness?.type ==
                                                    "SUPPLIER"
                                                ? "SALES"
                                                : "PURCHASE",
                                            '${widget.businessId}',
                                            query,
                                            '',
                                            '${e.id}',
                                            '');
                                        setState(() {
                                          isSubmit = false;
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              type == e.id ? orderColor : grey4,
                                        ),
                                        child: Text(
                                          '${e.name}',
                                          style: TextStyle(
                                              color:
                                                  type == e.id ? white : black),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        isSubmit == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: orderColor,
                                ),
                              )
                            : order.rows?.length == 0
                                ? NotFound(
                                    module: "ORDER",
                                    labelText: "Бараа олдсонгүй",
                                  )
                                : Column(
                                    children: order.rows!
                                        .map(
                                          (item) => Column(
                                            children: [
                                              OrderProductCard(
                                                isTap: packageProduct
                                                    .contains(item),
                                                readOnly: false,
                                                onClick: () {
                                                  if (item.quantity != null &&
                                                      item.quantity > 0 &&
                                                      widget.isPackage ==
                                                          false) {
                                                    widget
                                                        .productListenController
                                                        .productOrderChange(
                                                            item);
                                                    Navigator.of(context).pop();
                                                  } else if (widget.isPackage ==
                                                      true) {
                                                    if (packageProduct
                                                        .contains(item)) {
                                                      setState(() {
                                                        packageProduct
                                                            .removeWhere(
                                                                (element) =>
                                                                    element ==
                                                                    item);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        packageProduct
                                                            .add(item);
                                                      });
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        backgroundColor:
                                                            orderColor,
                                                        shape: StadiumBorder(),
                                                        content: Center(
                                                          child: Text(
                                                              'Тоо ширхэг нэмнэ үү!'),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                data: item,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                packageProduct.isNotEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: CustomButton(
                          onClick: () {
                            widget.packageListenController
                                .orderPackageProduct(packageProduct);
                            Navigator.of(context).pop();
                          },
                          labelText:
                              "${packageProduct.length} бараа = ${packageProduct.fold(0.0, (previousValue, element) => previousValue + (element.quantity!.toDouble() * element.price!))} ₮",
                          labelColor: orderColor,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
    );
  }
}
