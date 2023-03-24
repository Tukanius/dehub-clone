import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100,
        height: 100,
        color: yellow,
      ),
    );
  }
}
