import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectBranchType extends StatefulWidget {
  const SelectBranchType({
    super.key,
  });

  @override
  State<SelectBranchType> createState() => _SelectBranchTypeState();
}

class _SelectBranchTypeState extends State<SelectBranchType> {
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
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            children: general.branchTypes!.map((e) {
              return InkWell(
                onTap: () {
                  source.branchType(e.code!);
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text('${e.name}'),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
