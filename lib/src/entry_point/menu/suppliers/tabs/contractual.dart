import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class Contractual extends StatefulWidget {
  static const routeName = '/Contractual';
  const Contractual({super.key});

  @override
  State<Contractual> createState() => _ContractualState();
}

class _ContractualState extends State<Contractual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
    );
  }
}
