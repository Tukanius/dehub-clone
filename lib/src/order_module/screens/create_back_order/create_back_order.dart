import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class CreateBackOrderArguments {
  List<Order> orders;
  CreateBackOrderArguments({
    required this.orders,
  });
}

class CreateBackOrder extends StatefulWidget {
  static const routeName = '/CreateBackOrder';
  final List<Order> orders;
  const CreateBackOrder({
    super.key,
    required this.orders,
  });

  @override
  State<CreateBackOrder> createState() => CreateBackOrderState();
}

class CreateBackOrderState extends State<CreateBackOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: orderColor),
        surfaceTintColor: white,
        backgroundColor: white,
        title: const Text(
          'Захиалга багцлах',
          style: TextStyle(
            color: orderColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
