import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DistrictSheet extends StatefulWidget {
  const DistrictSheet({super.key});

  @override
  State<DistrictSheet> createState() => _DistrictSheetState();
}

class _DistrictSheetState extends State<DistrictSheet> {
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
            children: general.zipCodes!
                .where((element) => element.parent == source.partner.province)
                .map(
                  (e) => InkWell(
                    onTap: () {
                      source.district(e.code);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text("${e.name}"),
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
