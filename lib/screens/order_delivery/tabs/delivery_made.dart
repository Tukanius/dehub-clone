import 'package:dehub/components/delivery_card/delivery_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class DeliveryMade extends StatefulWidget {
  const DeliveryMade({super.key});

  @override
  State<DeliveryMade> createState() => _DeliveryMadeState();
}

class _DeliveryMadeState extends State<DeliveryMade> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          SearchButton(
            color: orderColor,
            textColor: orderColor,
          ),
          SizedBox(
            height: 5,
          ),
          DeliveryCard(
            data: Order(
              totalAmount: 100000,
              price: 1000,
            ),
          ),
        ],
      ),
    );
  }
}
