import 'package:dehub/components/not_found/not_found.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AfterLayoutMixin {
  @override
  afterFirstLayout(BuildContext context) {
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NotFound(
        module: "NETWORK",
        labelText: "Хоосон байна",
      ),
    );
  }
}
