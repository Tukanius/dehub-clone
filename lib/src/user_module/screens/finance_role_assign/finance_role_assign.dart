import 'package:dehub/components/selection_field/selection_field.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class FinanceRoleAssign extends StatefulWidget {
  static const routeName = '/FinanceRoleAssign';
  const FinanceRoleAssign({super.key});

  @override
  State<FinanceRoleAssign> createState() => _FinanceRoleAssignState();
}

class _FinanceRoleAssignState extends State<FinanceRoleAssign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Эрх тохируулах',
          style: TextStyle(
            color: userColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: userColor),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SelectionField(
                labelText: 'Банкны нэр',
                hintText: 'Сонгох',
                onClick: () {},
              ),
              SelectionField(
                labelText: 'Банктай харилцах ажилтан',
                hintText: 'Сонгох',
                onClick: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
