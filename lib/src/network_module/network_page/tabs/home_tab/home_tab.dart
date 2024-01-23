import 'package:dehub/components/not_found/not_found.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> with AfterLayoutMixin {
  @override
  afterFirstLayout(BuildContext context) {
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return const NotFound(
      module: "NETWORK",
      labelText: "Хоосон байна",
    );
  }
}
