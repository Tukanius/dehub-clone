import 'dart:async';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/invoice_product_card/invoice_product_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/invoice_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Shirhegeer extends StatefulWidget {
  final String businessId;
  final bool isPackage;
  final String discountAmount;
  final String shippingAmount;
  const Shirhegeer({
    required this.discountAmount,
    required this.shippingAmount,
    required this.isPackage,
    required this.businessId,
    super.key,
  });

  @override
  State<Shirhegeer> createState() => _ShirhegeerState();
}

class _ShirhegeerState extends State<Shirhegeer> with AfterLayoutMixin {
  bool isLoading = true;
  Result inventory = Result(rows: [], count: 0);
  int page = 1;
  int limit = 10;
  Timer? timer;
  String query = "";
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
                                      isPackage: false,
                                      readOnly: false,
                                      shippingAmount: widget.shippingAmount,
                                      discountAmount: widget.discountAmount,
                                      onClick: () {
                                        if (data.quantity != 0) {
                                          source.addCart(
                                            data,
                                            data.quantity,
                                            widget.discountAmount,
                                            widget.shippingAmount,
                                          );
                                          Navigator.of(context).pop();
                                        }
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
      ],
    );
  }
}
