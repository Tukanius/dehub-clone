import 'package:dehub/components/not_found/not_found.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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
