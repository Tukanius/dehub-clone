import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/shipment_distribution_card/shipment_distribution_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class ShipmentDistributionArguments {
  String id;
  ShipmentDistributionArguments({
    required this.id,
  });
}

class ShipmentDistribution extends StatefulWidget {
  final String id;
  static const routeName = '/ShipmentDistribution';
  const ShipmentDistribution({
    Key? key,
    required this.id,
  }) : super(key: key);

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
        iconTheme: IconThemeData(color: orderColor),
        elevation: 0,
        backgroundColor: white,
        title: Text(
          'Ачилт хуваарилах',
          style: TextStyle(
            color: orderColor,
            fontSize: 17,
          ),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(color: orderColor),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  approve.warehouses?.length != 0
                      ? Column(
                          children: approve.warehouses!
                              .map(
                                (data) => ShipmentDistributionCard(
                                  deliveryNoteId: approve.deliveryNote!.id!,
                                  data: data,
                                  lines: data.lines!,
                                ),
                              )
                              .toList(),
                        )
                      : NotFound(
                          module: "ORDER",
                          labelText: 'Ачилт хуваарилсан байна',
                        ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }
}
