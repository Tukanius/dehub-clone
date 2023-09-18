import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotFound extends StatefulWidget {
  final String module;
  final String? labelText;
  const NotFound({
    Key? key,
    this.labelText,
    required this.module,
  }) : super(key: key);

  @override
  State<NotFound> createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.module == "INVOICE"
            ? Lottie.asset('images/invoice-not-found.json')
            : widget.module == "ORDER"
                ? Lottie.asset(
                    'images/order-not-found.json',
                  )
                : widget.module == "NETWORK"
                    ? Lottie.asset(
                        'images/network-not-found.json',
                      )
                    : widget.module == "INVENTORY"
                        ? Lottie.asset('images/product-not-found.json')
                        : SizedBox(),
        const SizedBox(
          height: 20,
        ),
        Text(
          '${widget.labelText}',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
