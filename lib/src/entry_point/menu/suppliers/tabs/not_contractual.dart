import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class NotContractual extends StatefulWidget {
  static const routeName = '/NotContractual';
  const NotContractual({super.key});

  @override
  State<NotContractual> createState() => _NotContractualState();
}

class _NotContractualState extends State<NotContractual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
    );
  }
}
