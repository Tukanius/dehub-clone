import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectBusinessSubSector extends StatefulWidget {
  const SelectBusinessSubSector({super.key});

  @override
  State<SelectBusinessSubSector> createState() =>
      _SelectBusinessSubSectorState();
}

class _SelectBusinessSubSectorState extends State<SelectBusinessSubSector> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).partnerGeneral;
    final source = Provider.of<PartnerProvider>(context, listen: true);

    return Material(
      color: backgroundColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: general.businessSectors!
                .where((element) =>
                    element.parentId == source.partner.businessSectorId)
                .map(
                  (e) => InkWell(
                    onTap: () {
                      source.selectBusinessSubSector(e.id!, e.name!);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(e.name!),
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
