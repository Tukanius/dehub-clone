import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotFound extends StatefulWidget {
  final String module;
  final String? labelText;
  final Color? textColor;
  const NotFound({
    super.key,
    this.textColor,
    this.labelText,
    required this.module,
  });

  @override
  State<NotFound> createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.module == "INVOICE"
            ? Lottie.asset('assets/lottie/invoice-not-found.json')
            : widget.module == "ORDER"
                ? Lottie.asset(
                    'assets/lottie/order-not-found.json',
                  )
                : widget.module == "NETWORK" || widget.module == "PAYMENT"
                    ? Lottie.asset(
                        'assets/lottie/network-not-found.json',
                      )
                    : widget.module == "INVENTORY"
                        ? Lottie.asset('assets/lottie/product-not-found.json')
                        : widget.module == "DEBT"
                            ? Lottie.asset('/assets/lottie/debt-not-found.json')
                            : widget.module == "FINANCE"
                                ? Lottie.asset(
                                    'assets/lottie/invoice-not-found.json')
                                : const SizedBox(),
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            '${widget.labelText}',
            style: TextStyle(
              fontSize: 16,
              color: widget.textColor ?? widget.textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
