import 'package:dehub/components/delivery_card/delivery_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
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
            isDeliveried: false,
          ),
          DeliveryCard(
            isDeliveried: false,
          ),
          DeliveryCard(
            isDeliveried: false,
          ),
        ],
      ),
    );
  }
}
