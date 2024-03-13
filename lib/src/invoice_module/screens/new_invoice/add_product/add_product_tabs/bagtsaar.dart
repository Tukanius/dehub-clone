import 'dart:async';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/src/invoice_module/components/invoice_product_card/invoice_product_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/invoice_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bagtsaar extends StatefulWidget {
  final String businessId;
  final bool isPackage;
  final String shippingAmount;
  final String discountAmount;
  const Bagtsaar({
    required this.shippingAmount,
    required this.discountAmount,
    required this.isPackage,
    required this.businessId,
    super.key,
  });

  @override
  State<Bagtsaar> createState() => _BagtsaarState();
}

class _BagtsaarState extends State<Bagtsaar> with AfterLayoutMixin {
  bool isLoading = true;
  Result inventory = Result(rows: [], count: 0);
  int page = 1;
  int limit = 10;
  Timer? timer;
  ListenController listenController = ListenController();
  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit, '');
  }

  list(page, limit, String value) async {
    inventory = await InventoryApi().listGoods(widget.businessId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    listenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InvoiceProvider>(context, listen: true);
    return Column(
      children: [
        isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: invoiceColor,
                ),
              )
            : Expanded(
                child: SingleChildScrollView(
                  child: inventory.rows!.isEmpty
                      ? const NotFound(
                          module: "INVOICE",
                          labelText: "Хоосон байна!",
                        )
                      : Column(
                          children: [
                            Column(
                              children: inventory.rows!
                                  .map(
                                    (data) => InvoiceProductCard(
                                      shippingAmount: widget.shippingAmount,
                                      discountAmount: widget.discountAmount,
                                      isPackage: widget.isPackage,
                                      readOnly: false,
                                      onClick: () {
                                        FocusScope.of(context).unfocus();
                                      },
                                      data: data,
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                ),
              ),
        if (source.packageProduct.isNotEmpty && widget.isPackage == true)
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
              onClick: () async {
                for (var i = 0; i < source.packageProduct.length; i++) {
                  Provider.of<InvoiceProvider>(context, listen: false).addCart(
                    source.packageProduct[i],
                    source.packageProduct[i].quantity!,
                    widget.discountAmount,
                    widget.shippingAmount,
                  );
                }
                // source.packageProductClear();
                Navigator.of(context).pop();
              },
              labelText:
                  "${source.packageProduct.fold(0, (previousValue, element) => previousValue + element.quantity!)} бараа = ${Utils().formatCurrency(source.packageProduct.fold(0.0, (previousValue, element) => previousValue + (element.quantity!.toDouble() * element.price!)).toString())} ₮",
              labelColor: invoiceColor,
            ),
          ),
      ],
    );
  }
}
