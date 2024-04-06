import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/src/order_module/components/shipment_distribution_card/shipment_distribution_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class ShipmentDistributionArguments {
  String id;
  ListenController listenController;
  ShipmentDistributionArguments({
    required this.id,
    required this.listenController,
  });
}

class ShipmentDistribution extends StatefulWidget {
  static const routeName = '/ShipmentDistribution';
  final String id;
  final ListenController listenController;
  const ShipmentDistribution({
    super.key,
    required this.listenController,
    required this.id,
  });

  @override
  State<ShipmentDistribution> createState() => _ShipmentDistributionState();
}

class _ShipmentDistributionState extends State<ShipmentDistribution>
    with AfterLayoutMixin {
  Order approve = Order();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    approve = await OrderApi().deliveryManagementApprove(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: orderColor),
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        title: const Text(
          'Ачилт хуваарилах',
          style: TextStyle(
            color: orderColor,
            fontSize: 17,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(color: orderColor),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  approve.warehouses!.isNotEmpty
                      ? Column(
                          children: approve.warehouses!
                              .map(
                                (data) => ShipmentDistributionCard(
                                  deliveryNoteId: approve.deliveryNote!.id!,
                                  data: data,
                                  lines: data.lines!,
                                  listenController: widget.listenController,
                                ),
                              )
                              .toList(),
                        )
                      : const NotFound(
                          module: "ORDER",
                          labelText: 'Ачилт хуваарилсан байна',
                        ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }
}
