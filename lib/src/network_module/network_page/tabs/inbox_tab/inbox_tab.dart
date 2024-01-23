import 'package:dehub/src/network_module/network_page/tabs/inbox_tab/invitation.dart';
import 'package:flutter/material.dart';

class InboxTab extends StatefulWidget {
  const InboxTab({super.key});

  @override
  InboxTabState createState() => InboxTabState();
}

class InboxTabState extends State<InboxTab>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController tabController;
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  changePage(index) {
    setState(() {
      tabController.index = index;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.index = currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
          child: const Text(
            'Ирсэн урилга',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        const Invitation(),
      ],
    );
  }
}
