import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_module_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectDepartmentUnit extends StatefulWidget {
  const SelectDepartmentUnit({super.key});

  @override
  State<SelectDepartmentUnit> createState() => _SelectDepartmentUnitState();
}

class _SelectDepartmentUnitState extends State<SelectDepartmentUnit> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<UserModuleProvider>(context, listen: true);
    general = Provider.of<GeneralProvider>(context, listen: true).userGeneral;
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
            children: general.departmentUnits!
                .where((element) => element.parentId == null)
                .map(
                  (e) => InkWell(
                    onTap: () {
                      source.departmentUnit(e.id!);
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
