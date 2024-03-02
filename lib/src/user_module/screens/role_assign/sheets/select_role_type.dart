import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_module_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectRoleType extends StatefulWidget {
  const SelectRoleType({
    super.key,
  });

  @override
  State<SelectRoleType> createState() => _SelectRoleTypeState();
}

class _SelectRoleTypeState extends State<SelectRoleType> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).userGeneral;
    final source = Provider.of<UserModuleProvider>(context, listen: true);

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
            children: general.userRoleTypes!
                .map(
                  (e) => InkWell(
                    onTap: () {
                      source.selectRoleType(e.name!);
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