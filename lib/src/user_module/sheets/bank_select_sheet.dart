import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_module_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankSelectSheet extends StatefulWidget {
  final List banks;
  const BankSelectSheet({
    super.key,
    required this.banks,
  });

  @override
  State<BankSelectSheet> createState() => _BankSelectSheetState();
}

class _BankSelectSheetState extends State<BankSelectSheet> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).userGeneral;
    final source = Provider.of<UserModuleProvider>(context, listen: true);
    return Material(
      color: backgroundColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: widget.banks
                .map(
                  (e) => InkWell(
                    onTap: () {
                      source.selectBank(e.bank!);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          "${general.bankNames!.firstWhere((element) => element.code == e.bank).name}"),
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
