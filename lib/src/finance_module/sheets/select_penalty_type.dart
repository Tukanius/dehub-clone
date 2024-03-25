import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectPenaltyType extends StatefulWidget {
  const SelectPenaltyType({super.key});

  @override
  State<SelectPenaltyType> createState() => _SelectPenaltyTypeState();
}

class _SelectPenaltyTypeState extends State<SelectPenaltyType> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      color: backgroundColor,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Алдангийн арга сонгох',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Column(
                children: general.networkPenaltyTypes!
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          source.penaltyType(e.code!);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text('${e.name}'),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
