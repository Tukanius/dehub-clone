import 'dart:async';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/order_product_card/order_product_card.dart';
import 'package:dehub/components/scaffold_messenger/scaffold_messenger.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/checkout_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class ProductChooseArguments {
  ListenController listenController;
  bool isPackage;
  String businessId;
  ProductChooseArguments({
    required this.listenController,
    required this.isPackage,
    required this.businessId,
  });
}

class ProductChoose extends StatefulWidget {
  final ListenController listenController;
  final bool isPackage;
  final String businessId;
  static const routeName = '/ProductChoose';
  const ProductChoose({
    super.key,
    required this.listenController,
    required this.isPackage,
    required this.businessId,
  });

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
  List<Order> packageProduct = [];
  String type = '';
  ListenController listenController = ListenController();

  @override
  afterFirstLayout(BuildContext context) async {
    order = await OrderApi().variantSelect(
        user.currentBusiness?.type == "SUPPLIER" ? "SALES" : "PURCHASE",
        widget.businessId,
        query,
        '',
        '',
        '');
    category = await InventoryApi().category(
        user.currentBusiness?.type == "SUPPLIER" ? "SALES" : "PURCHASE",
        widget.businessId);
    setState(() {
      category.rows?.add(
        Order(id: '', name: 'Бүгд'),
      );
      isLoading = false;
    });
  }

  @override
  void initState() {
    listenController.addListener(() {
      setState(() {
        packageProduct = packageProduct;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: orderColor,
        surfaceTintColor: orderColor,
        elevation: 0,
        leading: const CustomCloseButton(),
        title: const Text(
          'Бараа сонгож нэмэх',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: white,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: white,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: category.rows!.reversed
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          packageProduct = [];
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
                                            widget.businessId,
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
                        const SizedBox(
                          height: 5,
                        ),
                        isSubmit == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: orderColor,
                                ),
                              )
                            : order.rows!.isEmpty
                                ? const NotFound(
                                    module: "ORDER",
                                    labelText: "Бараа олдсонгүй",
                                  )
                                : Column(
                                    children: order.rows!
                                        .map(
                                          (item) => Column(
                                            children: [
                                              OrderProductCard(
                                                isPackage: widget.isPackage,
                                                listenController:
                                                    listenController,
                                                package: packageProduct,
                                                readOnly: false,
                                                onClick: () {
                                                  if (widget.isPackage ==
                                                          false &&
                                                      item.quantity != 0) {
                                                    Navigator.of(context).pop();
                                                    Provider.of<CheckOutProvider>(
                                                            context,
                                                            listen: false)
                                                        .orderCart(item,
                                                            item.quantity);
                                                    widget.listenController
                                                        .changeVariable(
                                                            'addProduct');
                                                  } else if (widget.isPackage ==
                                                          false &&
                                                      item.quantity == 0) {
                                                    customScaffoldMessenger(
                                                      context,
                                                      color: orderColor,
                                                      labelText:
                                                          'Тоо ширхэг нэмнэ үү!',
                                                    );
                                                  }
                                                },
                                                data: item,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                if (packageProduct.isNotEmpty && widget.isPackage == true)
                  Container(
                    decoration: const BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: CustomButton(
                      onClick: () {
                        for (var i = 0; i < packageProduct.length; i++) {
                          Provider.of<CheckOutProvider>(context, listen: false)
                              .orderCart(packageProduct[i],
                                  packageProduct[i].quantity!);
                        }
                        Navigator.of(context).pop();
                        widget.listenController.changeVariable('addList');
                      },
                      labelText:
                          "${packageProduct.fold(0, (previousValue, element) => previousValue + element.quantity!)} бараа = ${Utils().formatCurrency(packageProduct.fold(0.0, (previousValue, element) => previousValue + (element.quantity!.toDouble() * element.price!)).toString())} ₮",
                      labelColor: orderColor,
                    ),
                  ),
              ],
            ),
    );
  }
}
