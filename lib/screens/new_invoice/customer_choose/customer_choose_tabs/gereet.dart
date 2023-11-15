import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class Gereet extends StatefulWidget {
  static const routeName = '/gereet';
  const Gereet({super.key});

  @override
  State<Gereet> createState() => _GereetState();
}

class _GereetState extends State<Gereet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
    );
  }
}
