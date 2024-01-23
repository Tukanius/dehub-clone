import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
          child: const Text(
            'Хэрэглэгч удирдлага',
            style: TextStyle(
                color: userColor, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
