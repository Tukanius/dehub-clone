import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with AfterLayoutMixin {
  bool isExpanded = false;

  @override
  afterFirstLayout(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 500),
            bottom: isExpanded ? 50 : 100,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: black,
              ),
              height: 500,
              width: isExpanded ? 350 : 300,
            ),
          ),
          AnimatedPositioned(
            curve: Curves.ease,
            bottom: isExpanded ? 150 : 100,
            duration: const Duration(milliseconds: 500),
            child: GestureDetector(
              onTap: () {},
              onPanUpdate: onPanUpdate,
              child: Container(
                height: 500,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}
