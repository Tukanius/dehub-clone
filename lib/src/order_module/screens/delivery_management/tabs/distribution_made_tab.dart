import 'package:dehub/components/delivery_management_card/delivery_management_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/src/order_module/screens/shipment_distribution/shipment_distribution.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class DistributionMadeTab extends StatefulWidget {
  const DistributionMadeTab({super.key});

  @override
  State<DistributionMadeTab> createState() => _DistributionMadeTabState();
}

class _DistributionMadeTabState extends State<DistributionMadeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        SearchButton(
          color: orderColor,
          borderColor: grey,
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DeliveryManagementCard(
                  isFinished: true,
                  onClick: () {
                    Navigator.of(context)
                        .pushNamed(ShipmentDistribution.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
