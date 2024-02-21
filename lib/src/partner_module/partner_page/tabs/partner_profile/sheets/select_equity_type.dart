import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectEquityType extends StatefulWidget {
  const SelectEquityType({super.key});

  @override
  State<SelectEquityType> createState() => SelectEquityTypeState();
}

class SelectEquityTypeState extends State<SelectEquityType> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<PartnerProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).partnerGeneral;
    return Material(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      color: backgroundColor,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: general.equityTypes!
                .map(
                  (e) => InkWell(
                    onTap: () {
                      source.equityType(e.code!);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(e.name.toString()),
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
