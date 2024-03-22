import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankAccountSelect extends StatefulWidget {
  const BankAccountSelect({super.key});

  @override
  State<BankAccountSelect> createState() => _BankAccountSelectState();
}

class _BankAccountSelectState extends State<BankAccountSelect> {
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
                'Банк сонгох',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Column(
                children: general.bankAccounts!
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          source.bankAccountSelect(e);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundImage: NetworkImage(e.icon!),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text('${e.number} / ${e.bankName}'),
                            ],
                          ),
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
