import 'package:dehub/components/shipment_distribution_card/shipment_distribution_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ShipmentDistribution extends StatefulWidget {
  static const routeName = '/ShipmentDistribution';
  const ShipmentDistribution({Key? key}) : super(key: key);

  @override
  State<ShipmentDistribution> createState() => _ShipmentDistributionState();
}

class _ShipmentDistributionState extends State<ShipmentDistribution> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShipmentDistributionCard(),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
