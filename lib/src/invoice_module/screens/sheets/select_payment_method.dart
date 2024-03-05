import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/invoice_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({
    super.key,
  });

  @override
  State<SelectPaymentMethod> createState() => SelectPaymentMethodState();
}

class SelectPaymentMethodState extends State<SelectPaymentMethod> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InvoiceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).invoiceGeneral;

    return Material(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      color: backgroundColor,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: general.paymentMethod!
                .where((element) =>
                    element.code != "BANK_CARD" && element.code != "SOCIAL_PAY")
                .map(
                  (e) => InkWell(
                    onTap: () {
                      source.selectPaymentMethod(e.code!);
                      Navigator.of(context).pop();
                    },
                    child: Material(
                      color: transparent,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text('${e.name}'),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
